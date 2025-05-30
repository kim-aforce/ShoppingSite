package jp.co.aforce.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {		
//		removuAttributeはuserだけ消すセッションIDは維持されている。
//		session.removeAttribute("user");
		try {
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.invalidate(); //セッション無効化
			}
			response.sendRedirect(request.getContextPath() + "/views/login-in.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
