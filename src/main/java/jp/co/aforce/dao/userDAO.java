package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jp.co.aforce.beans.userBean;

public class userDAO extends DAO {

	//ユーザー認証処理
	public userBean login(String id, String pw) throws Exception {
		userBean users = null;

		Connection con = getConnection();

		//		ユーザー入力値でSQL文準備
		String sql = "SELECT * FROM users WHERE member_id=? AND password=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, pw);

		//		結果をrsに格納
		ResultSet rs = ps.executeQuery();

		//		結果が存在すればuserBean obj生成　フィールド設定
		if (rs.next()) {
			users = new userBean();
			users.setMemberId(rs.getString("member_id"));
			users.setPassword(rs.getString("password"));
			users.setLastname(rs.getString("last_name"));
		}

		rs.close();
		ps.close();
		con.close();

		return users;
	}

/*===================================================================
 --------------------------------------------新規会員登録----------------------------------- 
 *================================================================== */
	public boolean register(userBean user) throws Exception {

		Connection con = getConnection();
		String sql = "INSERT INTO users "
				+ "(member_id, password, last_name, first_name, address, mail_address) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, user.getMemberId());
		ps.setString(2, user.getPassword());
		ps.setString(3, user.getLastname());
		ps.setString(4, user.getFirstname());
		ps.setString(5, user.getAddress());
		ps.setString(6, user.getMailAddress());
		
		int result = ps.executeUpdate();
		ps.close();
		con.close();
	    return result > 0;  // 1件以上登録成功したら trueにreturn、falseは登録失敗
	}
}
