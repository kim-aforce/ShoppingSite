package jp.co.aforce.servlet.AdminServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jp.co.aforce.beans.ProductBean;
import jp.co.aforce.dao.AdminProductDAO;

/**
 * Servlet implementation class AdminProductList
 */
@WebServlet("/views/admin/product")
public class AdminProductList extends HttpServlet {
	   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		//DAOインスタンス
		AdminProductDAO dao = new AdminProductDAO();
		
		List<ProductBean>products;
		try {
			//全商品取得
			products = dao.getAllProducts();
		} catch (SQLException e) {
			//DBエラーはServletExceptionで投げる
			throw new ServletException();
			}
		//リクエスト属性に商品リストをセットする
		request.setAttribute("products", products);
		
		//商品管理品一覧JSPへフォワード
		request.getRequestDispatcher("/views/admin/AdminProductList.jsp")
		.forward(request, response);
		
	}
	
	
	
	
	
	
	
	
	
	
	

}
