package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jp.co.aforce.beans.CategoryBean;

public class CategoryDAO extends DAO {

    /**
     * カテゴリを全件取得
     */
    public List<CategoryBean> getAllCategories() throws SQLException {
        String sql = "SELECT * FROM categories";
        List<CategoryBean> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CategoryBean c = new CategoryBean();
                c.setCategory_id(rs.getString("category_id"));
                c.setCategory_name(rs.getString("category_name"));
                list.add(c);
            }
        }
        return list;
    }
}