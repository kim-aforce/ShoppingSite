package jp.co.aforce.servlet.ProductServlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jp.co.aforce.beans.ProductBean;
import jp.co.aforce.dao.ProductDAO;

/**
 * 商品詳細表示サーブレット
 */
@WebServlet("/views/product/ProductDetail")
public class ProductDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 商品IDパラメータ取得
		String productIdParam = request.getParameter("id");
		
		// IDパラメータチェック
		if (productIdParam == null || productIdParam.trim().isEmpty()) {
			// IDが指定されていない場合は商品一覧へリダイレクト
			response.sendRedirect(request.getContextPath() + "/views/product/ProductList");
			return;
		}

		try {
			int productId = Integer.parseInt(productIdParam); // IDを整数に変換
			ProductDAO dao = new ProductDAO();
			ProductBean product = dao.getProductById(productId); // 商品情報取得

			if (product == null) {
				// 商品が見つからない場合
				request.setAttribute("errorMessage", "指定された商品が見つかりません。");
				request.setAttribute("returnUrl", "/views/product/ProductList");
				RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
				rd.forward(request, response);
				return;
			}

			// 商品情報をリクエスト属性にセット
			request.setAttribute("product", product);
			
			// 消費税込み価格計算（10%）
			double priceWithTax = product.getPrice() * 1.1;
			request.setAttribute("priceWithTax", Math.round(priceWithTax));

			// 商品詳細JSPへフォワード
			RequestDispatcher rd = request.getRequestDispatcher("/views/product/ProductDetail.jsp");
			rd.forward(request, response);

		} catch (NumberFormatException e) {
			// IDが数値でない場合
			request.setAttribute("errorMessage", "不正な商品IDです。");
			request.setAttribute("returnUrl", "/views/product/ProductList");
			RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
			rd.forward(request, response);
		} catch (SQLException e) {
			// DBエラー
			throw new ServletException("データベースエラーが発生しました。", e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}