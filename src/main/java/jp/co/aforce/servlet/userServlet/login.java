package jp.co.aforce.servlet.userServlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.userDAO;

@WebServlet("/views/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		userBean user = null;

		try {
			userDAO dao = new userDAO();
			user = dao.login(id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		
		//ログイン処理　ロジック
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user); //ユーザーにセッション付与
			//成功
			RequestDispatcher rdSucess = request.getRequestDispatcher("/views/user-menu.jsp");
			rdSucess.forward(request, response);
			//失敗
		} else {
			RequestDispatcher rdFailed = request.getRequestDispatcher("/views/Error.jsp");
			rdFailed.forward(request, response);
		}
		//ID / PW 入力チェック　コンソール用
		System.out.println(" ID: " + id);
		System.out.println(" PW: " + pw);
	}
}
