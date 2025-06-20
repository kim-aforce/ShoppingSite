package jp.co.aforce.servlet.userServlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class logout extends HttpServlet {
	private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // removuAttributeはuserだけ消すセッションIDは維持されている。
        // session.removeAttribute("user");
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))
                || "true".equals(request.getParameter("ajax"));
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // セッション無効化
            }
            if (isAjax) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\"}");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/Main/Top.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
