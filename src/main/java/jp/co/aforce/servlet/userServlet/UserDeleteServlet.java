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


@WebServlet("/views/userdelete-confirm")
public class UserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		 HttpSession session = request.getSession();
	        userBean user = (userBean) session.getAttribute("user");
	        
                if (user == null) {
                    request.setAttribute("errorMessage", "セッションが切れました。再度ログインしてください。");
                    request.setAttribute("returnUrl", "login-in.jsp");
                    RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
                    rd.forward(request, response);
                    return;
                }
	        
	        
	        //削除するユーザー情報をrequestに渡す
	        request.setAttribute("user", user);
	        RequestDispatcher rd = request.getRequestDispatcher("/views/userDeleteConfirm.jsp");
	        rd.forward(request, response);
	        
	        
	        
	}

}
