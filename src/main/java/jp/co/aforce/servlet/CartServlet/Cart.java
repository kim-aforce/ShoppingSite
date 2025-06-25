package jp.co.aforce.servlet.CartServlet;

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
import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.CartDAO;

@WebServlet("/cart")
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * カート表示処理
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// セッション確認
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

			// カート項目取得（商品情報JOIN済み）
			List<CartBean> cartItems = cartDAO.getCartByMemberId(user.getMemberId());
			double totalAmount = 0.0;

			// 合計金額計算（JOIN結果活用）
			for (CartBean cart : cartItems) {
				totalAmount += cart.getPrice() * cart.getQuantity();
			}

			// リクエスト属性設定
			request.setAttribute("cartItems", cartItems);
			request.setAttribute("totalAmount", totalAmount);
			request.setAttribute("itemCount", cartItems.size());

			// カート画面へフォワード
			RequestDispatcher rd = request.getRequestDispatcher("/views/cart/Cart.jsp");
			rd.forward(request, response);

		} catch (SQLException e) {
			handleError(request, response, "データベースエラーが発生しました。", e);
		}
	}

	/**
	 * カート操作処理
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// セッション確認
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

		String action = request.getParameter("action");

		try {
			CartDAO cartDAO = new CartDAO();

			switch (action) {
			case "add":
				addToCart(request, cartDAO, user.getMemberId());
				break;
			case "update":
				updateCartQuantity(request, cartDAO);
				break;
			case "remove":
				removeFromCart(request, cartDAO);
				break;
			case "clear":
				clearCart(cartDAO, user.getMemberId());
				break;
			default:
				handleError(request, response, "無効な操作です。", null);
				return;
			}

			// カート画面へリダイレクト
			response.sendRedirect(request.getContextPath() + "/cart");

		} catch (SQLException e) {
			handleError(request, response, "データベースエラーが発生しました。", e);
		} catch (NumberFormatException e) {
			handleError(request, response, "入力値が正しくありません。", e);
		}
	}

	/**
	 * カート追加処理
	 */
	private void addToCart(HttpServletRequest request, CartDAO cartDAO, String memberId)
			throws SQLException, NumberFormatException {

		int productId = Integer.parseInt(request.getParameter("productId"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		if (quantity <= 0) {
			throw new IllegalArgumentException("数量は1以上である必要があります。");
		}

		CartBean cart = new CartBean();
		cart.setMember_id(memberId);     // 会員ID設定
		cart.setProduct_id(productId);   // 商品ID設定
		cart.setQuantity(quantity);      // 数量設定

		cartDAO.addToCart(cart);         // カート追加実行
	}

	/**
	 * カート数量更新処理
	 */
	private void updateCartQuantity(HttpServletRequest request, CartDAO cartDAO)
			throws SQLException, NumberFormatException {

		int cartId = Integer.parseInt(request.getParameter("cartId"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		cartDAO.updateQuantity(cartId, quantity);    // 数量更新実行
	}

	/**
	 * カート項目削除処理
	 */
	private void removeFromCart(HttpServletRequest request, CartDAO cartDAO)
			throws SQLException, NumberFormatException {

		int cartId = Integer.parseInt(request.getParameter("cartId"));
		cartDAO.removeFromCart(cartId);              // カート項目削除実行
	}

	/**
	 * カート全削除処理
	 */
	private void clearCart(CartDAO cartDAO, String memberId) throws SQLException {
		cartDAO.clearCart(memberId);                 // カート全削除実行
	}

	/**
	 * ログインページリダイレクト
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
			e.printStackTrace();                      // コンソールログ出力
		}

		request.setAttribute("errorMessage", message);
		request.setAttribute("returnUrl", "/cart");
		RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
		rd.forward(request, response);
	}
}