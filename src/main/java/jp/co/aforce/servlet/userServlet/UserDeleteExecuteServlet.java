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


@WebServlet("/views/userdelete-execute")
public class UserDeleteExecuteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
  			throws ServletException, IOException {
  		request.setCharacterEncoding("UTF-8");
  		
  		HttpSession session = request.getSession();
  		userBean user = (userBean) session.getAttribute("user");
  		
                if (user== null) {
                        request.setAttribute("errorMessage", "セッションが切れました。再度ログインしてください。");
                        request.setAttribute("returnUrl", "login-in.jsp");
                        RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
                        rd.forward(request, response);
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
                                request.setAttribute("errorMessage", "削除に失敗しました。");
                                request.setAttribute("returnUrl", "user-menu.jsp");
                                RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
                                rd.forward(request, response);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("errorMessage", "例外発生: " + e.getMessage());
                        request.setAttribute("returnUrl", "user-menu.jsp");
                        RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
                        rd.forward(request, response);
                }
  		
  	}

}
