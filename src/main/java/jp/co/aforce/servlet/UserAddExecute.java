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

/**
 * Servlet implementation class UserAddExecute
 */
@WebServlet("/views/useradd-excute")
public class UserAddExecute extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session  = request.getSession(false);
		
		if (session == null) {
			response.sendRedirect("user-add.jsp?error=セッション切れ");
			return;
		}
		
		userBean user = (userBean) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect("user-add.jsp?error=情報未入力");
			return;
		}
		
		try {
			userDAO dao = new userDAO();
			boolean result = dao.register(user);
			if (result) {
				response.sendRedirect("userComplete.jsp");
			}else {
				response.sendRedirect("user-add.jsp?error=登録失敗");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("user-add.jsp?error=例外発生");
		}
		
	}

}
