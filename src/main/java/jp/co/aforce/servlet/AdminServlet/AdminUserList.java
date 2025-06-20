package jp.co.aforce.servlet.AdminServlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.userDAO;

/**
 * 管理者用 会員管理サーブレット
 */
@WebServlet("/admin/users")
public class AdminUserList extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		userDAO dao = new userDAO();

		List<userBean> users;
		try {
			// 全会員取得
			users = dao.getAllUsers();
		} catch (Exception e) {
			// DBエラーはServletExceptionで投げる
			throw new ServletException(e);
		}
		// リクエスト属性に会員リストをセット
		request.setAttribute("users", users);

		// 会員管理一覧JSPへフォワード
		request.getRequestDispatcher("/views/admin/AdminUserList.jsp")
				.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		String memberId = request.getParameter("memberId");
		userDAO dao = new userDAO();

		try {
			if ("delete".equals(action)) {
				// 会員削除
				dao.deleteById(memberId);
			} else if ("updateType".equals(action)) {
				// 権限変更
				String userType = request.getParameter("userType");
				dao.updateUserType(memberId, userType);
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}

		// 処理後一覧へリダイレクト
		response.sendRedirect(request.getContextPath() + "/admin/users");
	}
}