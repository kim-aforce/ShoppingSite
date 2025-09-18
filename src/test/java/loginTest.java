import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.junit.jupiter.api.Test;
import org.mockito.MockedConstruction;

import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.userDAO;
import jp.co.aforce.servlet.userServlet.login;



//loginクラスを継承して、protectedメソッド(doPost)を呼び出せるようにする
class TestableLogin extends login {
 // ラッパーメソッド：テスト側からdoPostにアクセスするため
 public void invokeDoPost(HttpServletRequest req, HttpServletResponse resp) throws Exception {
     super.doPost(req, resp);
 }
}

public class loginTest {

 @Test
 void testLoginSuccess() throws Exception {
     // --- モックの準備 ---
     HttpServletRequest request = mock(HttpServletRequest.class);
     HttpServletResponse response = mock(HttpServletResponse.class);
     HttpSession session = mock(HttpSession.class);
     RequestDispatcher dispatcher = mock(RequestDispatcher.class);
     
     // --- リクエストの入力値を設定 ---
     when(request.getParameter("id")).thenReturn("user01");
     when(request.getParameter("pw")).thenReturn("pass01");
     when(request.getHeader("X-Requested-With")).thenReturn(null);
     when(request.getParameter("ajax")).thenReturn(null);
     when(request.getRequestDispatcher("/views/user-menu.jsp")).thenReturn(dispatcher); // 正常時の遷移先
     when(request.getSession()).thenReturn(session);
     
     //成功ケース userBean準備
     userBean user = new userBean();
     user.setMemberId("user01");
     user.setPassword("pass01");
     
     try (MockedConstruction<userDAO> mocked = mockConstruction(userDAO.class,
             (mock, context) -> when(mock.login("user01", "pass01")).thenReturn(user))) {
     // --- テスト対象のサーブレットを呼び出し ---
     TestableLogin servlet = new TestableLogin();
     servlet.invokeDoPost(request, response); // protected doPostを呼び出す
     
 } 

     // --- 結果検証 ---
     verify(session).setAttribute(eq("user"), any()); // セッションにユーザー情報が保存されたか確認
     verify(dispatcher).forward(request, response);   // 正常画面にフォワードされたか確認
 }

 @Test
 void testLoginFailed() throws Exception {
     // --- モックの準備 ---
     HttpServletRequest request = mock(HttpServletRequest.class);
     HttpServletResponse response = mock(HttpServletResponse.class);
     RequestDispatcher dispatcher = mock(RequestDispatcher.class);

     // --- 不正な入力値を設定 ---
     when(request.getParameter("id")).thenReturn("badId");      // 存在しないID
     when(request.getParameter("pw")).thenReturn("wrongPw");    // 誤ったパスワード
     when(request.getRequestDispatcher("/views/Error.jsp")).thenReturn(dispatcher); // 失敗時の遷移先
     
     // --- userDAOのモックを設定 ---
		try (MockedConstruction<userDAO> mocked = mockConstruction(
				userDAO.class, (mock, context) -> when(mock.login("badId", "wrongPw")).thenReturn(null)))
	{
     // --- テスト対象のサーブレットを呼び出し ---
     TestableLogin servlet = new TestableLogin();
     servlet.invokeDoPost(request, response);
 	}
     // --- 結果検証 ---
     verify(dispatcher).forward(request, response); // エラーページに遷移したか
     verify(request, never()).getSession();         // セッションが生成されていないか
 }
}