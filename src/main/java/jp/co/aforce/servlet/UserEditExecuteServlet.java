package jp.co.aforce.servlet;

import java.io.IOException;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        userBean editUser = (userBean) session.getAttribute("editUser");
       
        
        try {
            userDAO dao = new userDAO();
            boolean success = dao.update(editUser);
            
            if (success) {
                session.setAttribute("user", editUser);
                session.removeAttribute("editUser"); 
                response.sendRedirect("userEditComplete.jsp");
            } else {
                response.sendRedirect("user-edit.jsp?error=更新失敗");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-edit.jsp?error=例外発生");
        }
    }
}