package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jp.co.aforce.beans.ProductBean;

/**
 * 管理者向け 商品管理DAO
 */
public class AdminProductDAO extends DAO {
	// 全商品取得メソッド
	public List<ProductBean> getAllProducts() throws SQLException {
		String sql = "SELECT * FROM products";
		try (Connection con = getConnection(); // DB接続取得
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			List<ProductBean> list = new ArrayList<>(); // 商品Bean格納リスト
			while (rs.next()) {
				list.add(mapRow(rs)); // 1行ずつBeanにマッピング
			}
			return list;
		}
	}

	//単一品目取得メソッド
	public ProductBean getProductById(int id) throws SQLException {
		String sql = "SELECT * FROM products WHERE product_id = ?";
		try (Connection con = getConnection(); // DB接続取得
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, id); // IDパラメータ設定
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs); // Bean返却
				}
				return null; // 未存在時null返却
			}
		}
	}

	// 新規商品登録メソッド
	public void insertProduct(ProductBean p) throws SQLException {
		String sql = "INSERT INTO products "
				+ "(product_name, description, price, category_id, stock_qty, image_url) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection con = getConnection(); // DB接続取得
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, p.getProduct_name()); // 商品名設定
			ps.setString(2, p.getDescription()); // 説明設定 
			ps.setDouble(3, p.getPrice()); // 価格設定
			ps.setString(4, p.getCategory_id()); // カテゴリ設定
			ps.setInt(5, p.getStock_qty()); // 在庫数設定
			ps.setString(6, p.getImage_url()); // 画像URL設定
			ps.executeUpdate(); // INSERT実行
		}
	}
	//商品修正メソッド
	public void updateProduct(ProductBean p) throws SQLException {
        String sql = "UPDATE products SET "
                   + "product_name = ?, description = ?, price = ?, "
                   + "category_id = ?, stock_qty = ?, image_url = ? "
                   + "WHERE product_id = ?";
        try (Connection con = getConnection();                    //DB接続取得
             PreparedStatement ps = con.prepareStatement(sql)) {  //SQL準備

            ps.setString(1, p.getProduct_name());                // 商品名設定
            ps.setString(2, p.getDescription());                 //説明設定
            ps.setDouble(3, p.getPrice());                       // 価格設定
            ps.setString(4, p.getCategory_id());                 // カテゴリ設定
            ps.setInt(5, p.getStock_qty());                      //在庫数設定
            ps.setString(6, p.getImage_url());                   //画像URL設定
            ps.setInt(7, p.getProduct_id());                     // WHERE条件ID
            ps.executeUpdate();                                  // UPDATE実行
        }
    }
	
	
	
	// 商品削除メソッド
    public void deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (Connection con = getConnection();               // DB接続取得
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);                                // IDパラメータ設定
            ps.executeUpdate();                             // DELETE実行
        }
    }
    //ResultSet > ProductBean Mapping Helper
    private ProductBean mapRow(ResultSet rs) throws SQLException{
    	ProductBean p = new ProductBean();
    	p.setProduct_id(rs.getInt("product_id"));            // product_id
        p.setProduct_name(rs.getString("product_name"));     // product_name
        p.setDescription(rs.getString("description"));       // description
        p.setPrice(rs.getDouble("price"));                   // price
        p.setCategory_id(rs.getString("category_id"));       // category_id 
        p.setStock_qty(rs.getInt("stock_qty"));              // stock_qty 
        p.setImage_url(rs.getString("image_url"));           // image_url
        return p;                                            // Bean返却 
    } 
}