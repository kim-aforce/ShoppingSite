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
}
