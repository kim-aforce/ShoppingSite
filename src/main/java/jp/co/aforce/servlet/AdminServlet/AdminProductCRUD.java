package jp.co.aforce.servlet.AdminServlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jp.co.aforce.beans.ProductBean;
import jp.co.aforce.dao.AdminProductDAO;

/**
 *管理者用 商品CRUDサーブレット
 * URLパターン: /admin/products/new, /admin/products/edit, /admin/products/delete
 */ 
@WebServlet(urlPatterns = {
	    "/admin/products/new",
	    "/admin/products/edit",
	    "/admin/products/delete"})
public class AdminProductCRUD extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();                        // リクエストパス取得
        AdminProductDAO dao = new AdminProductDAO();                   // DAOインスタンス生成

        // 削除処理 / 삭제 처리
        if (path.endsWith("/delete")) {
            String idParam = request.getParameter("id");               // 削除対象ID取得
            if (idParam != null && !idParam.isBlank()) {
                try {
                    int id = Integer.parseInt(idParam);                // IDを整数に変換
                    dao.deleteProduct(id);                             // DELETE実行
                } catch (NumberFormatException | SQLException e) {
                    throw new ServletException(e);
                }
            }
            // 処理後一覧へリダイレクト
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        // 登録・編集フォームの表示
        ProductBean p = new ProductBean();                             // 新規Bean生成
        String mode;

        // 編集モード判定
        if (path.endsWith("/edit")) {
            mode = "edit";                                             // モードをeditに設定
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isBlank()) {
                try {
                    int id = Integer.parseInt(idParam);
                    ProductBean dbBean = dao.getProductById(id);       // DBから既存商品取得
                    if (dbBean != null) {
                        p = dbBean;                                    // Beanに既存データをセット
                    }
                } catch (NumberFormatException | SQLException e) {
                    throw new ServletException(e);
                }
            }
        } else {
            mode = "new"; // 新規モード
        }

        // フォーム用データをリクエスト属性にセット
        request.setAttribute("product", p);
        request.setAttribute("mode", mode);

        // フォームJSPへフォワード
        request.getRequestDispatcher("/admin/adminProductForm.jsp")
               .forward(request, response);
    }

    /**
     * POSTリクエスト: 登録または編集実行
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();                        // リクエストパス取得
        AdminProductDAO dao = new AdminProductDAO();                   // DAOインスタンス生成 
        ProductBean p = new ProductBean();

        // フォームパラメータからBeanにセット
        p.setProduct_name(request.getParameter("product_name"));       
        p.setDescription(request.getParameter("description"));         
        p.setPrice(Double.parseDouble(request.getParameter("price"))); 
        p.setCategory_id(request.getParameter("category_id"));         
        p.setStock_qty(Integer.parseInt(request.getParameter("stock_qty")));
        p.setImage_url(request.getParameter("image_url"));             

        try {
            if (path.endsWith("/new")) {
                dao.insertProduct(p);									// INSERT実行
            } else {
                p.setProduct_id(Integer.parseInt(request.getParameter("product_id"))); 
                dao.updateProduct(p);                                  // UPDATE実行
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // 完了後一覧へリダイレクト
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}


