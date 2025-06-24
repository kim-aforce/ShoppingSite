package jp.co.aforce.servlet.OrderServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jp.co.aforce.beans.OrderBean;
import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.OrderDAO;

/**
 * Servlet implementation class OrderHistory
 */
@WebServlet("/views/order/OrderHistory")
public class OrderHistory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * ログインリダイレクト
	 */
	private void redirectToLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		response.sendRedirect(request.getContextPath() + "/views/login-in.jsp");
	}
	/**
     * エラー処理
     */
    private void handleError(HttpServletRequest request, HttpServletResponse response,
            String message, Exception e) throws ServletException, IOException {
        if (e != null) {
            e.printStackTrace(); // コンソールログ出力
        }
        request.setAttribute("errorMessage", message);
        request.setAttribute("returnUrl", "/views/Main/Top.jsp");
        RequestDispatcher rd = request.getRequestDispatcher("/views/Error.jsp");
        rd.forward(request, response);
    }
    
    
	/**
	 * 注文履歴表示サーブレット
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		//Session確認
		HttpSession session  = request.getSession(false);
		if (session == null) {
			redirectToLogin(request, response);
			return;
		}
		
		userBean user = (userBean)session.getAttribute("user");
		if (user == null) {
			redirectToLogin(request, response);
			return;
		}
		
		try {
			OrderDAO orderDAO = new OrderDAO();
			//会員の注文履歴取得
			List<OrderBean> orderList = orderDAO.getOrdersByMemberId(user.getMemberId());
			
			//Request属性設定
			request.setAttribute("orderList", orderList);
			request.setAttribute("user", user);
			
			//注文履歴JSPフォワード
			RequestDispatcher rd = request.getRequestDispatcher("OrderHistory.jsp");
			rd.forward(request, response);
		} catch (SQLException e) {
			handleError(request, response, "注文履歴の取得に失敗しました。", e);
		}
	}

	
}
