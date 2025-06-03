package jp.co.aforce.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.userDAO;


@WebServlet("/views/userdelete-execute")
public class UserDeleteExecuteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
  			throws ServletException, IOException {
  		request.setCharacterEncoding("UTF-8");
  		
  		HttpSession session = request.getSession();
  		userBean user = (userBean) session.getAttribute("user");
  		
  		if (user== null) {
			response.sendRedirect("login-in.jsp?error=セッション切れ");
			return;
		}
  		
  		try {
			userDAO dao = new userDAO();
			boolean success = dao.delete(user);
			
			if (success) {
				//削除成功時セッション無効（自動ログアウト）
				session.invalidate();
				response.sendRedirect(request.getContextPath() + "/views/userDeleteSuccess.jsp");
			}else {
				response.sendRedirect("user-menu.jsp?error=削除失敗");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("user-menu.jsp?error=例外発生");
		}
  		
  	}

}
