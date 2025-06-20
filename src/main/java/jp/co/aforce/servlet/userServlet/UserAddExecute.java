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

		HttpSession session = request.getSession(false);

		if (session == null) {
            request.setAttribute("errorMessage", "セッションが切れました。再度ログインしてください。");
            request.setAttribute("returnUrl", "login-in.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
            rd.forward(request, response);
            return;
        }

		userBean user = (userBean) session.getAttribute("user");
		if (user == null) {
            request.setAttribute("errorMessage", "ユーザー情報が見つかりません。最初からやり直してください。");
            request.setAttribute("returnUrl", "user-add.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
            rd.forward(request, response);
            return;
        }
		
		// 入力検証
        if (user.getMemberId() == null || user.getMemberId().trim().isEmpty() ||
            user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "必須項目が入力されていません。");
            request.setAttribute("returnUrl", "user-add.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
            rd.forward(request, response);
            return;
        }

        try {
            userDAO dao = new userDAO();
            
            // BL1: ID 重複チェック
            if (dao.exists(user.getMemberId())) {
                // エラーメッセージ
                request.setAttribute("errorMessage", "入力したユーザーIDとパスワードは、すでに登録済みです。");
                request.setAttribute("returnUrl", "user-add.jsp");
                RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
                rd.forward(request, response);
                return;
            }

            // BL2: 
            boolean registerResult = dao.register(user);
            
            if (!registerResult) {
                request.setAttribute("errorMessage", "登録エラー");
                request.setAttribute("returnUrl", "user-add.jsp");
                RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
                rd.forward(request, response);
                return;
            }

            // セッション破棄
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/views/userComplete.jsp");
            
            // 成功ログ
            System.out.println("会員登録成功: " + user.getMemberId());

        } catch (Exception e) {
            // 例外
            System.err.println("会員登録中例外発生: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("errorMessage", "システムエラーが発生しました。しばらく後に再度お試しください。");
            request.setAttribute("returnUrl", "user-add.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
            rd.forward(request, response);
        }
    }
}
