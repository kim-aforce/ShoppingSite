import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.jupiter.api.Test;

import jp.co.aforce.beans.userBean;
import jp.co.aforce.dao.userDAO;

public class userDaoTest {
	
	 // 正しいID/PWでログインできる
    @Test
    void testLoginSuccess() throws Exception {
        Connection con = mock(Connection.class);
        PreparedStatement ps = mock(PreparedStatement.class);
        ResultSet rs = mock(ResultSet.class);

        when(con.prepareStatement(anyString())).thenReturn(ps);
        when(ps.executeQuery()).thenReturn(rs);
        when(rs.next()).thenReturn(true);
        when(rs.getString("member_id")).thenReturn("user01");
        when(rs.getString("password")).thenReturn("pass01");

        userDAO dao = new TestUserDAO(con);
        userBean user = dao.login("user01", "pass01");
        assertNotNull(user);
        assertEquals("user01", user.getMemberId());
        assertEquals("pass01", user.getPassword());
    }

    // getConnectionのモック
    static class TestUserDAO extends userDAO {
        private final Connection con;
        TestUserDAO(Connection con) { this.con = con; }
        @Override
        protected Connection getConnection() throws java.sql.SQLException {
            return con;
        }
    }
}