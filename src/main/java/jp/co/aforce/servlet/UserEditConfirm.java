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
    private static final long serialVersionUID = 1L;
    
    // GET要求は拒否
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login-in.jsp?error=不正アクセス");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== UserEditConfirm: 確認ページ処理開始 ===");
        
        request.setCharacterEncoding("UTF-8");

        // セッション確認
        HttpSession session = request.getSession();
        userBean sessionUser = (userBean) session.getAttribute("user");

        if (sessionUser == null) {
            System.out.println("セッション切れ - ログインページへ");
            response.sendRedirect("login-in.jsp?error=セッション切れ");
            return;
        }

        System.out.println("現在ログイン中ユーザー: " + sessionUser.getMemberId());

        // 新しい編集用オブジェクト作成
        userBean editUser = new userBean();
        editUser.setMemberId(sessionUser.getMemberId());
        editUser.setPassword(sessionUser.getPassword());

        // フォームデータ取得
        String lastname = request.getParameter("lastname");
        String firstname = request.getParameter("firstname");
        String mailAddress = request.getParameter("mailAddress");
        String address = request.getParameter("address");

        System.out.println("入力データ確認:");
        System.out.println("- 姓: " + lastname);
        System.out.println("- 名: " + firstname);
        System.out.println("- メール: " + mailAddress);
        System.out.println("- 住所: " + address);

        // 空文字列チェックして既存値保持
        if (lastname != null && !lastname.trim().isEmpty()) {
            editUser.setLastname(lastname.trim());
            System.out.println("新しい姓: " + lastname.trim());
        } else {
            editUser.setLastname(sessionUser.getLastname());
            System.out.println("既存姓維持: " + sessionUser.getLastname());
        }
        
        if (firstname != null && !firstname.trim().isEmpty()) {
            editUser.setFirstname(firstname.trim());
            System.out.println("新しい名設定: " + firstname.trim());
        } else {
            editUser.setFirstname(sessionUser.getFirstname());
            System.out.println("既存名維持: " + sessionUser.getFirstname());
        }
        
        if (mailAddress != null && !mailAddress.trim().isEmpty()) {
            editUser.setMailAddress(mailAddress.trim());
            System.out.println("新しい メール設定: " + mailAddress.trim());
        } else {
            editUser.setMailAddress(sessionUser.getMailAddress());
            System.out.println("既存メール維持: " + sessionUser.getMailAddress());
        }
        
        if (address != null && !address.trim().isEmpty()) {
            editUser.setAddress(address.trim());
            System.out.println("新しい 住所設定: " + address.trim());
        } else {
            editUser.setAddress(sessionUser.getAddress());
            System.out.println("既存住所維持: " + sessionUser.getAddress());
        }


        // セッションに編集データ保存
        session.setAttribute("editUser", editUser);

        // 確認ページへ転送
        RequestDispatcher rd = request.getRequestDispatcher("/views/userEditConfirm.jsp");
        rd.forward(request, response);
        
        System.out.println("確認ページへ転送完了");
    }
}