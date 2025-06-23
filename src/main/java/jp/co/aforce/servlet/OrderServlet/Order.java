package jp.co.aforce.servlet.OrderServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jp.co.aforce.beans.CartBean;
import jp.co.aforce.beans.OrderBean;
import jp.co.aforce.beans.ProductBean;
import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.CartDAO;
import jp.co.aforce.dao.OrderDAO;
import jp.co.aforce.dao.ProductDAO;

@WebServlet("/order")
public class Order extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * 注文フォーム表示
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            redirectToLogin(request, response);
            return;
        }

        userBean user = (userBean) session.getAttribute("user");
        if (user == null) {
            redirectToLogin(request, response);
            return;
        }

        try {
            CartDAO cartDAO = new CartDAO();
            ProductDAO productDAO = new ProductDAO();
            
            // カート項目取得
            List<CartBean> cartItems = cartDAO.getCartByMemberId(user.getMemberId());
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // 商品情報追加・合計計算
            double totalAmount = 0.0;
            for (CartBean cart : cartItems) {
                ProductBean product = productDAO.getProductById(cart.getProduct_id());
                if (product != null) {
                    request.setAttribute("product_" + cart.getCart_id(), product);
                    totalAmount += product.getPrice() * cart.getQuantity();
                }
            }
            
            // リクエスト属性設定
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("user", user);
            
            // 注文フォームへフォワード
            RequestDispatcher rd = request.getRequestDispatcher("/views/order/OrderForm.jsp");
            rd.forward(request, response);
            
        } catch (SQLException e) {
            handleError(request, response, "データベースエラーが発生しました。", e);
        }
    }

    /**
     * 注文処理実行
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            redirectToLogin(request, response);
            return;
        }

        userBean user = (userBean) session.getAttribute("user");
        if (user == null) {
            redirectToLogin(request, response);
            return;
        }

        try {
            CartDAO cartDAO = new CartDAO();
            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();
            
            // カート項目取得
            List<CartBean> cartItems = cartDAO.getCartByMemberId(user.getMemberId());
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // 合計金額計算
            double totalAmount = calculateTotal(cartItems, productDAO);
            
            // 注文Bean作成
            OrderBean order = new OrderBean();
            order.setMember_id(user.getMemberId());                    // 会員ID設定
            order.setTotal_amount(totalAmount);                        // 合計金額設定
            order.setOrder_status("PENDING");                          // 注文状態設定
            
            String shippingAddress = request.getParameter("shippingAddress");
            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                shippingAddress = user.getAddress();                   // デフォルト住所使用
            }
            order.setDelivery_address(shippingAddress);                // 配送先設定
            
            // 注文作成
            int orderId = orderDAO.createOrder(order);                 // 注文INSERT
            orderDAO.addOrderItems(orderId, cartItems, productDAO);    // 注文商品INSERT
            
            // 在庫減算
            for (CartBean cart : cartItems) {
                orderDAO.updateProductStock(cart.getProduct_id(), cart.getQuantity());
            }
            
            // カート削除
            cartDAO.clearCart(user.getMemberId());                     // カート空にする
            
            // 注文完了画面へリダイレクト
            response.sendRedirect(request.getContextPath() + "/views/order/OrderComplete.jsp?orderId=" + orderId);
            
        } catch (SQLException e) {
            handleError(request, response, "注文処理中にエラーが発生しました。", e);
        }
    }
    
    /**
     * 合計金額計算
     */
    private double calculateTotal(List<CartBean> cartItems, ProductDAO productDAO) 
            throws SQLException {
        double total = 0.0;
        for (CartBean cart : cartItems) {
            ProductBean product = productDAO.getProductById(cart.getProduct_id());
            if (product != null) {
                total += product.getPrice() * cart.getQuantity();      // 小計加算
            }
        }
        return total;
    }
    
    /**
     * ログインリダイレクト
     */
    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/views/login-in.jsp");
    }
    
    /**
     * エラー処理
     */
    private void handleError(HttpServletRequest request, HttpServletResponse response, 
                           String message, Exception e) throws ServletException, IOException {
        if (e != null) {
            e.printStackTrace();                                       // コンソールログ出力
        }
        request.setAttribute("errorMessage", message);
        request.setAttribute("returnUrl", "/cart");
        RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
        rd.forward(request, response);
    }
}