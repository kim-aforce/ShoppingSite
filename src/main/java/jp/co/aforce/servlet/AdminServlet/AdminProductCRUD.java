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
 * 管理者用 商品CRUDサーブレット（修正版）
 * URLパターン: /admin/products/new, /admin/products/edit, /admin/products/delete
 * 
 * 🔧 修正内容:
 * - 操作完了後のリダイレクトにresultパラメータ追加
 * - エラーハンドリング強化
 * - ログ出力改善
 */ 
@WebServlet(urlPatterns = {
	    "/admin/products/new",
	    "/admin/products/edit",
	    "/admin/products/delete"})
public class AdminProductCRUD extends HttpServlet {

    /**
     * GETリクエスト処理: フォーム表示または削除実行
     */
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();                        // リクエストパス取得
        AdminProductDAO dao = new AdminProductDAO();                   // DAOインスタンス生成

        // 🔧 修正: 削除処理の強化
        if (path.endsWith("/delete")) {
            String idParam = request.getParameter("id");               // 削除対象ID取得
            if (idParam != null && !idParam.isBlank()) {
                try {
                    int id = Integer.parseInt(idParam);                // IDを整数に変換
                    
                    // 🆕 削除前に商品存在確認
                    ProductBean existingProduct = dao.getProductById(id);
                    if (existingProduct == null) {
                        System.err.println("[削除エラー] 商品ID " + id + " が見つかりません");
                        response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
                        return;
                    }
                    
                    dao.deleteProduct(id);                             // DELETE実行
                    System.out.println("[削除成功] 商品ID: " + id + " 商品名: " + existingProduct.getProduct_name());
                    
                    // 🆕 成功時のリダイレクト（resultパラメータ付き）
                    response.sendRedirect(request.getContextPath() + "/admin/products?result=deleted");
                    
                } catch (NumberFormatException e) {
                    System.err.println("[削除エラー] 無効な商品ID: " + idParam);
                    response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
                } catch (SQLException e) {
                    System.err.println("[削除エラー] データベースエラー: " + e.getMessage());
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
                }
            } else {
                System.err.println("[削除エラー] 商品IDが指定されていません");
                response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
            }
            return;
        }

        // 🔧 修正: 登録・編集フォームの表示処理強化
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
                        System.out.println("[編集フォーム表示] 商品ID: " + id + " 商品名: " + dbBean.getProduct_name());
                    } else {
                        System.err.println("[編集エラー] 商品ID " + id + " が見つかりません");
                        response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
                        return;
                    }
                } catch (NumberFormatException e) {
                    System.err.println("[編集エラー] 無効な商品ID: " + idParam);
                    response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
                    return;
                } catch (SQLException e) {
                    System.err.println("[編集エラー] データベースエラー: " + e.getMessage());
                    throw new ServletException(e);
                }
            } else {
                System.err.println("[編集エラー] 商品IDが指定されていません");
                response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
                return;
            }
        } else {
            mode = "new"; // 新規モード
            System.out.println("[新規登録フォーム表示]");
        }

        // フォーム用データをリクエスト属性にセット
        request.setAttribute("product", p);
        request.setAttribute("mode", mode);

        // フォームJSPへフォワード
        request.getRequestDispatcher("/views/admin/AdminProductForm.jsp")
               .forward(request, response);
    }

    /**
     * POSTリクエスト処理: 登録または編集実行（修正版）
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();                        // リクエストパス取得
        AdminProductDAO dao = new AdminProductDAO();                   // DAOインスタンス生成 
        ProductBean p = new ProductBean();

        try {
            //  修正: フォームパラメータ検証強化
            String productName = request.getParameter("product_name");
            String description = request.getParameter("description");
            String priceParam = request.getParameter("price");
            String categoryId = request.getParameter("category_id");
            String stockParam = request.getParameter("stock_qty");
            
            //  必須パラメータ検証
            if (productName == null || productName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "商品名は必須です");
                redirectToForm(request, response, path, p);
                return;
            }
            
            if (priceParam == null || priceParam.trim().isEmpty()) {
                request.setAttribute("errorMessage", "価格は必須です");
                redirectToForm(request, response, path, p);
                return;
            }
            
            if (categoryId == null || categoryId.trim().isEmpty()) {
                request.setAttribute("errorMessage", "カテゴリは必須です");
                redirectToForm(request, response, path, p);
                return;
            }

            // フォームパラメータからBeanにセット
            p.setProduct_name(productName.trim());
            p.setDescription(description != null ? description.trim() : "");
            
            try {
                p.setPrice(Double.parseDouble(priceParam));
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "価格は正しい数値を入力してください");
                redirectToForm(request, response, path, p);
                return;
            }
            
            p.setCategory_id(categoryId);
            
            try {
                p.setStock_qty(Integer.parseInt(stockParam));
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "在庫数は正しい数値を入力してください");
                redirectToForm(request, response, path, p);
                return;
            }

            //  修正: 画像URL処理の改善
            String imageUrl = request.getParameter("image_url");
            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                if (path.endsWith("/new")) {
                    request.setAttribute("errorMessage", "商品画像をアップロードしてください");
                    redirectToForm(request, response, path, p);
                    return;
                } else {
                    // 編集時は既存画像を維持
                    try {
                        int id = Integer.parseInt(request.getParameter("product_id"));
                        ProductBean existingProduct = dao.getProductById(id);
                        if (existingProduct != null) {
                            imageUrl = existingProduct.getImage_url();
                        }
                    } catch (Exception e) {
                        System.err.println("[画像URL取得エラー] " + e.getMessage());
                        e.printStackTrace();
                    }
                }
            }
            p.setImage_url(imageUrl);

            // 修正: データベース操作の実行
            if (path.endsWith("/new")) {
                dao.insertProduct(p);
                System.out.println("[新規商品登録完了] 商品名: " + p.getProduct_name() + " 画像: " + imageUrl);
                response.sendRedirect(request.getContextPath() + "/admin/products?result=created");
                
            } else {
                String productIdParam = request.getParameter("product_id");
                if (productIdParam == null || productIdParam.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "商品IDが見つかりません");
                    redirectToForm(request, response, path, p);
                    return;
                }
                
                try {
                    p.setProduct_id(Integer.parseInt(productIdParam));
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "無効な商品IDです");
                    redirectToForm(request, response, path, p);
                    return;
                }
                
                dao.updateProduct(p);
                System.out.println("[商品更新完了] ID: " + p.getProduct_id() + " 商品名: " + p.getProduct_name() + " 画像: " + imageUrl);
                response.sendRedirect(request.getContextPath() + "/admin/products?result=updated");
            }
            
        } catch (SQLException e) {
            System.err.println("[データベースエラー] " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
        } catch (Exception e) {
            System.err.println("[予期しないエラー] " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?result=error");
        }
    }
    
    /**
     *  フォームリダイレクトヘルパーメソッド
     * エラー時にフォームページに戻る処理を共通化
     */
    private void redirectToForm(HttpServletRequest request, HttpServletResponse response, 
                               String path, ProductBean product) throws ServletException, IOException {
        String mode = path.endsWith("/new") ? "new" : "edit";
        request.setAttribute("product", product);
        request.setAttribute("mode", mode);
        request.getRequestDispatcher("/views/admin/AdminProductForm.jsp").forward(request, response);
    }
}