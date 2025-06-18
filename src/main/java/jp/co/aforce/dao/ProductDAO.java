package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jp.co.aforce.beans.ProductBean;

public class ProductDAO extends DAO{
	
	/*===================================================================
	 --------------------------------------------全商品取得----------------------------------- 
	 *================================================================== */
	public List<ProductBean> getAllProducts() throws SQLException{
		List<ProductBean> list = new ArrayList<>();
		
		String sql = "SELECT * FROM products";
		List<ProductBean> list = new ArrayList<>();
		try (Connection con = getConnection();
	             PreparedStatement ps = con.prepareStatement(sql);
	             ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                ProductBean p = mapRow(rs);
	                list.add(p);
	            }
	        }
	        return list;
	}
	
	/*===================================================================
	 --------------------------------------------カテゴラ別取得--------------------------------------------
	 *================================================================== */
	public List<ProductBean> getProductsByCategory(String categoryId) throws SQLException {
        String sql = "SELECT * FROM products WHERE category_id = ?";
        List<ProductBean> list = new ArrayList<>();
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }
	
	/*===================================================================
	 --------------------------------------------キーワード検索----------------------------------- 
	 *================================================================== */
	
	
	
	/*===================================================================
	 --------------------------------------------ResultSet→Beanマッピング----------------------------------- 
	 *================================================================== */
    private ProductBean mapRow(ResultSet rs) throws SQLException {
        ProductBean p = new ProductBean();
        p.setProduct_id(rs.getInt("product_id"));
        p.setProduct_name(rs.getString("product_name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setCategory_id(rs.getString("category_id"));
        p.setStock_qty(rs.getInt("stock_qty"));
        p.setImage_url(rs.getString("image_url"));
        return p;
    }
}
	
	
	
	
	
	
	
	
	
