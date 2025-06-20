// AdminFilter.java
package jp.co.aforce.servlet.AdminServlet;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jp.co.aforce.beans.userBean;

/**
 * 管理者専用フィルタ
 * user_typeが'ADMIN' のみ通過
 */
@WebFilter(urlPatterns = "/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初期化処理不要
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req  = (HttpServletRequest) request;      // HttpServletRequest にキャスト 
        HttpServletResponse res = (HttpServletResponse) response;     // HttpServletResponse にキャスト
        HttpSession session     = req.getSession(false);              // 既存セッションを取得 

        boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"))
                || "true".equals(req.getParameter("ajax"));
        
        // セッションがない、またはユーザ情報がなければログインへ
        if (session == null || session.getAttribute("user") == null) {
        	if (isAjax) {
                res.setContentType("application/json");
                res.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                res.getWriter().write("{\"status\":\"unauthenticated\"}");
            } else {
                res.sendRedirect(req.getContextPath() + "/views/login-in.jsp");    // ログインページへリダイレクト
            }            return;
        }

        userBean user = (userBean) session.getAttribute("user");      // セッションからUserBeanを取得
        // user_typeが'ADMIN'かチェック
        if ("ADMIN".equals(user.getUserType())) {
            chain.doFilter(request, response);                        // 通過
        } else {
        	if (isAjax) {
                res.setContentType("application/json");
                res.setStatus(HttpServletResponse.SC_FORBIDDEN);
                res.getWriter().write("{\"status\":\"forbidden\"}");
            } else {
                res.sendRedirect(req.getContextPath() + "/views/admin/unauthorized.jsp"); // アクセス拒否ページへ
            }
        }
    }

    @Override
    public void destroy() {
        // 終了処理不要 
    }
}
