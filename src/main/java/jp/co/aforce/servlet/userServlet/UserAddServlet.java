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

@WebServlet("/views/useradd")
public class UserAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 文字エンコーディング設定
        request.setCharacterEncoding("UTF-8");
        
        // パラメータ取得
        String memberId = request.getParameter("memberId");
        String password = request.getParameter("password");
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        
        // 入力検証
        if (memberId == null || memberId.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            
            // エラーメッセージ設定
            request.setAttribute("errorMessage", "必須項目が入力されていません。");
            request.setAttribute("returnUrl", "user-add.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
            rd.forward(request, response);
            return;
        }
        
        try {
            // userBeanオブジェクト生成
            userBean user = new userBean();
            user.setMemberId(memberId);
            user.setPassword(password);
            user.setLastname(lastname);
            user.setFirstname(firstname);
            user.setMailAddress(email);
            user.setAddress(address);
            
            // セッションにユーザー情報保存
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // 確認画面へ遷移
            RequestDispatcher rd = request.getRequestDispatcher("/views/userAddConfirm.jsp");
            rd.forward(request, response);
            
        } catch (Exception e) {
            // 例外処理
            e.printStackTrace();
            request.setAttribute("errorMessage", "システムエラーが発生しました");
            request.setAttribute("returnUrl", "user-add.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
            rd.forward(request, response);
        }
    }
}