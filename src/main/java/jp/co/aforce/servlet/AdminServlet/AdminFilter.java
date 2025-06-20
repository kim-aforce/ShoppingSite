// AdminFliter.java
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
 * 管理者専用フィルタ / 관리자 전용 필터
 * user_typeが'ADMIN' のみ通過 / user_type이 'ADMIN'인 경우만 통과
 */
@WebFilter(urlPatterns = "/admin/*")
public class AdminFliter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初期化処理不要 / 초기화 로직 없음
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req  = (HttpServletRequest) request;      // HttpServletRequest にキャスト 
        HttpServletResponse res = (HttpServletResponse) response;     // HttpServletResponse にキャスト
        HttpSession session     = req.getSession(false);              // 既存セッションを取得 

        // セッションがない、またはユーザ情報がなければログインへ
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login-in.jsp");    // ログインページへリダイレクト 
            return;
        }

        userBean user = (userBean) session.getAttribute("user");      // セッションからUserBeanを取得
        // user_typeが'ADMIN'かチェック / user_type이 ADMIN인지 검사
        if ("ADMIN".equals(user.getUserType())) {
            chain.doFilter(request, response);                        // 通過 
        } else {
            res.sendRedirect(req.getContextPath() + "/unauthorized.jsp"); // アクセス拒否ページへ 
        }
    }

    @Override
    public void destroy() {
        // 終了処理不要 
    }
}
