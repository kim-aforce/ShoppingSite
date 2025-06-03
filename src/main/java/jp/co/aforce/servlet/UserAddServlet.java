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


@WebServlet("/views/useradd")
public class UserAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		userBean user = new userBean();
		
		user.setMemberId(request.getParameter("memberId"));
		user.setPassword(request.getParameter("password"));
		user.setLastname(request.getParameter("lastname"));
		user.setFirstname(request.getParameter("firstname"));
		user.setMailAddress(request.getParameter("email"));
		user.setAddress(request.getParameter("address"));
		
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/userAddConfirm.jsp");
		rd.forward(request, response);
	}

}
