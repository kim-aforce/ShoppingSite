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
       
    // GET要求は拒否
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("errorMessage", "不正アクセス");
        request.setAttribute("returnUrl", "login-in.jsp");
        RequestDispatcher rd = request.getRequestDispatcher("/views/login-error.jsp");
        rd.forward(request, response);
    }

    // POST要求のみ処理
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
                
        // セッション確認
        HttpSession session = request.getSession();
        userBean user = (userBean) session.getAttribute("user");
        
        if (user == null) {
            request.setAttribute("errorMessage", "セッションが切れました。再度ログインしてください。");
            request.setAttribute("returnUrl", "login-in.jsp");
            RequestDispatcher rdErr = request.getRequestDispatcher("/views/login-error.jsp");
            rdErr.forward(request, response);
            return;
        }
        
        System.out.println("ユーザー情報確認: " + user.getMemberId());
        
        // 編集フォームに現在の情報を渡す
        request.setAttribute("user", user);
        RequestDispatcher rd = request.getRequestDispatcher("/views/user-edit.jsp");
        rd.forward(request, response);
        
        System.out.println("編集ページへ転送完了");
    }
}