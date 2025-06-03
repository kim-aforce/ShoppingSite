package jp.co.aforce.servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jp.co.aforce.beans.userBean;

@WebServlet("/views/useredit")
public class UserEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
        userBean user = (userBean) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login-in.jsp?error=セッション切れ");
            return;
        }
        
        request.setAttribute("user", user);
        RequestDispatcher rd = request.getRequestDispatcher("/views/user-edit.jsp");
        rd.forward(request, response);
    }
}
