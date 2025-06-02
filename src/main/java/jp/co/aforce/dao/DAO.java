package jp.co.aforce.dao;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DAO {
	static DataSource ds;

	public Connection getConnection() throws Exception {
		if (ds == null) {
			try {
				InitialContext ic = new InitialContext();
				ds = (DataSource) ic.lookup("java:/comp/env/jdbc/ShoppingSite");
			} catch (Exception e) {
				throw new Exception("テータソース取得失敗");
				
			}
		}
		return ds.getConnection();
	}
}