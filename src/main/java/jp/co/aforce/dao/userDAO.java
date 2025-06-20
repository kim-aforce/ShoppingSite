package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jp.co.aforce.beans.userBean;

public class userDAO extends DAO {

	
/*===================================================================
 --------------------------------------------ログイン処理----------------------------------- 
 *================================================================== */
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
			users.setFirstname(rs.getString("first_name"));
			users.setAddress(rs.getString("address"));
			users.setMailAddress(rs.getString("mail_address"));
            // 管理者判定に使用するユーザー種別を取得
            users.setUserType(rs.getString("user_type"));
		}

		rs.close();
		ps.close();
		con.close();

		return users;
	}

	/*===================================================================
	 --------------------------------------------新規会員登録 （sql insert）----------------------------------- 
	 *================================================================== */
	public boolean register(userBean user) throws Exception {
		//1.2 会員情報が正常に登録された場合　TRUE返し
		//1.3 会員情報が登録できなかった場合、FALSE返し

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
		return result > 0; // 1件以上登録成功したら trueにreturn、falseは登録失敗
	}

	//重複検査
	public boolean exists(String memberId) throws Exception {
		Connection con = getConnection();
		String sql = "SELECT member_id FROM users WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberId);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		con.close();
		return exists;
	}

	/*===================================================================
	 --------------------------------------------会員情報削除 （sql delete）-------------------------------------------------------- 
	 *================================================================== */
	public boolean delete(userBean user) throws Exception {
		Connection con = getConnection();
		
	    String sql = "DELETE FROM users WHERE member_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
	    ps.setString(1, user.getMemberId());

	    
		int result = ps.executeUpdate();
		ps.close();
		con.close();
		
		return result > 0; //削除成功したらtrue
	}

	/*===================================================================
	 --------------------------------------------会員情報修正　（sql update）-------------------------------------------------------- 
	 *================================================================== */
	public boolean update(userBean user) throws Exception {
		Connection con = getConnection();
	    
	    String sql = "UPDATE users SET " 
	               + "password = ?, "
	               + "last_name = ?, " 
	               + "first_name = ?, "
	               + "address = ?, " 
	               + "mail_address = ? " 
	               + "WHERE member_id = ?";
	               
	    PreparedStatement ps = con.prepareStatement(sql);
	    ps.setString(1, user.getPassword());
	    ps.setString(2, user.getLastname());
	    ps.setString(3, user.getFirstname());
	    ps.setString(4, user.getAddress());
	    ps.setString(5, user.getMailAddress());
	    ps.setString(6, user.getMemberId());
	    
	    int result = ps.executeUpdate();
	    ps.close();
	    con.close();
	    
	    return result > 0;

	}

}
