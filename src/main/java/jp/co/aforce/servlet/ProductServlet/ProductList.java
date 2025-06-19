package jp.co.aforce.servlet.ProductServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jp.co.aforce.beans.CategoryBean;
import jp.co.aforce.beans.ProductBean;
import jp.co.aforce.dao.CategoryDAO;
import jp.co.aforce.dao.ProductDAO;

//このServletは、クエリパラメータsearchやcategoryに基づきProductDAOを使って商品リストを取得し、JSPへ転送するロジック。デフォルトは全件表示

@WebServlet("/views/product/ProductList")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//商品一覧は参照処理であり、パラメータはURL経由で渡すため、doPostではなくdoGetを使うのがHTTP的にもUX的にも適切。
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//Query Parameter 「category」を取得
		String category = request.getParameter("category");
		//Query Parameter 「search」を取得
		String search = request.getParameter("search");

		ProductDAO dao = new ProductDAO();
		CategoryDAO cDao = new CategoryDAO();
		//商品一覧格納用リスト定義　初期値null
		List<ProductBean> productList = null;
		List<CategoryBean> categoryList = null;

		try {
			// カテゴリ一覧取得
			categoryList = cDao.getAllCategories();
			//検索キーワードが指定された場合
			if (search != null && !search.trim().isEmpty()) {
				//キーワード検索実行
				productList = dao.searchProducts(search);

				//カテゴリが指定された場合			
			} else if (category != null && !category.trim().isEmpty()) {
				//カテゴリ別検索実行
				productList = dao.getProductsByCategory(category);

				//両方指定されていない場合
			} else {
				//全商品取得
				productList = dao.getAllProducts();
			}
			// SQLエラー発生時にServlet例外として投げる
		} catch (SQLException e) {
			throw new ServletException(e);
		}

		request.setAttribute("products", productList);
		request.setAttribute("categories", categoryList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/product/ProductList.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
