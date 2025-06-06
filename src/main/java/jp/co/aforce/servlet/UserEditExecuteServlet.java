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
import jp.co.aforce.dao.userDAO;

@WebServlet("/views/useredit-execute")
public class UserEditExecuteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // GET拒否
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("GET요求でアクセス試行 - 拒否");
        response.sendRedirect("login-in.jsp?error=不正アクセス");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== UserEditExecuteServlet: 実行開始 ===");
        
        // セッション確認
        HttpSession session = request.getSession();
        userBean editUser = (userBean) session.getAttribute("editUser");
        
        System.out.println("editUser存在確認: " + (editUser != null));
        
        if (editUser == null) {
            System.out.println("editUserが null - セッション切れ");
            response.sendRedirect("login-in.jsp?error=セッション切れ");
            return;
        }
        
        System.out.println("更新対象ユーザー: " + editUser.getMemberId());
        System.out.println("更新データ:");
        System.out.println("- 姓: " + editUser.getLastname());
        System.out.println("- 名: " + editUser.getFirstname());
        System.out.println("- メール: " + editUser.getMailAddress());
        System.out.println("- 住所: " + editUser.getAddress());
        
        try {
            System.out.println("DAO更新処理開始...");
            userDAO dao = new userDAO();
            boolean success = dao.update(editUser);
            
            System.out.println("DAO更新結果: " + success);
            
            if (success) {
                System.out.println("更新成功 - セッション情報更新中...");
                
                //セッション更新
                session.setAttribute("user", editUser);
                session.removeAttribute("editUser");
                
                System.out.println("セッション更新完了");
                System.out.println("完了ページへ転送中: /views/userEditComplete.jsp");
                
                // 完了ページへフォワード
                RequestDispatcher rd = request.getRequestDispatcher("/views/userEditComplete.jsp");
                rd.forward(request, response);
                
                
            } else {
                System.out.println("更新失敗 - エラーページへリダイレクト");
                // エラーメッセージの属性名は JSP 側の期待に合わせる
                request.setAttribute("errorMessage", "データベース更新に失敗しました");
                RequestDispatcher rd = request.getRequestDispatcher("/views/login-error.jsp");
                rd.forward(request, response);
            }
            
        } catch (Exception e) {
            System.out.println("例外発生: " + e.getMessage());
            e.printStackTrace();
            
            // 例外発生時エラーページへフォワード
            // 例外内容をユーザーに知らせる際も属性名を統一
            request.setAttribute("errorMessage", "システムエラー発生: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/views/login-error.jsp");
            rd.forward(request, response);
        }
        
    }
}