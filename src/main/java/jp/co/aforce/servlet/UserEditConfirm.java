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

@WebServlet("/views/useredit-confirm")
public class UserEditConfirm extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		userBean sessionUser = (userBean) session.getAttribute("user");

		if (sessionUser == null) {
			response.sendRedirect("login-in.jsp?error=セッション切れ");
			return;
		}

		userBean editUser = new userBean();
		editUser.setMemberId(sessionUser.getMemberId());
		editUser.setPassword(sessionUser.getPassword());

		String lastname = request.getParameter("lastname");
		String firstname = request.getParameter("firstname");
		String mailAddress = request.getParameter("mailAddress");
		String address = request.getParameter("address");

		editUser.setLastname(lastname != null ? lastname : sessionUser.getLastname());
		editUser.setFirstname(firstname != null ? firstname : sessionUser.getFirstname());
		editUser.setMailAddress(mailAddress != null ? mailAddress : sessionUser.getMailAddress());
		editUser.setAddress(address != null ? address : sessionUser.getAddress());

		session.setAttribute("editUser", editUser);

		RequestDispatcher rd = request.getRequestDispatcher("/views/userEditConfirm.jsp");
		rd.forward(request, response);
	}
}
