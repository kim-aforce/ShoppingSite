package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jp.co.aforce.beans.CartBean;

/**
 * カート管理DAO
 */
public class CartDAO extends DAO {
    
    /**
     * カートに商品追加
     */
    public void addToCart(CartBean cart) throws SQLException {
        // 既存カート項目チェック
        CartBean existingCart = getCartItem(cart.getMember_id(), cart.getProduct_id());
        
        if (existingCart != null) {
            // 既存項目の数量更新
            updateQuantity(existingCart.getCart_id(), 
                          existingCart.getQuantity() + cart.getQuantity());
        } else {
            // 新規カート項目追加
            String sql = "INSERT INTO cart (member_id, product_id, quantity) VALUES (?, ?, ?)";
            try (Connection con = getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {
                
                ps.setString(1, cart.getMember_id());      // 会員ID設定
                ps.setInt(2, cart.getProduct_id());        // 商品ID設定
                ps.setInt(3, cart.getQuantity());          // 数量設定
                ps.executeUpdate();                        // INSERT実行
            }
        }
    }
    
    /**
     * 会員別カート項目取得（商品情報含む）
     */
    public List<CartBean> getCartByMemberId(String memberId) throws SQLException {
        String sql = "SELECT c.cart_id, c.member_id, c.product_id, c.quantity, c.created_at, " +
                    "p.product_name, p.price, p.image_url " +
                    "FROM cart c JOIN products p ON c.product_id = p.product_id " +
                    "WHERE c.member_id = ? ORDER BY c.created_at DESC";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, memberId);                     // 会員IDパラメータ設定
            
            try (ResultSet rs = ps.executeQuery()) {
                List<CartBean> cartList = new ArrayList<>();
                while (rs.next()) {
                    CartBean cart = mapRow(rs);            // ResultSet→Bean変換
                    cartList.add(cart);
                }
                return cartList;
            }
        }
    }
    
    /**
     * 特定カート項目取得
     */
    private CartBean getCartItem(String memberId, int productId) throws SQLException {
        String sql = "SELECT * FROM cart WHERE member_id = ? AND product_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, memberId);                     // 会員ID設定
            ps.setInt(2, productId);                       // 商品ID設定
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);                     // Bean返却
                }
                return null;                               // 未存在時null返却
            }
        }
    }
    
    /**
     * カート項目数量更新
     */
    public void updateQuantity(int cartId, int quantity) throws SQLException {
        if (quantity <= 0) {
            removeFromCart(cartId);                        // 数量0以下は削除
            return;
        }
        
        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, quantity);                        // 新数量設定
            ps.setInt(2, cartId);                          // カートID設定
            ps.executeUpdate();                            // UPDATE実行
        }
    }
    
    /**
     * カート項目削除
     */
    public void removeFromCart(int cartId) throws SQLException {
        String sql = "DELETE FROM cart WHERE cart_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, cartId);                          // カートID設定
            ps.executeUpdate();                            // DELETE実行
        }
    }
    
    /**
     * 会員カート全削除
     */
    public void clearCart(String memberId) throws SQLException {
        String sql = "DELETE FROM cart WHERE member_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, memberId);                     // 会員ID設定
            ps.executeUpdate();                            // DELETE実行
        }
    }
    
    /**
     * カート項目数取得
     */
    public int getCartItemCount(String memberId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM cart WHERE member_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, memberId);                     // 会員ID設定
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);                   // カウント返却
                }
                return 0;
            }
        }
    }
    
    /**
     * ResultSet→CartBeanマッピング
     */
    private CartBean mapRow(ResultSet rs) throws SQLException {
        CartBean cart = new CartBean();
        cart.setCart_id(rs.getInt("cart_id"));            // カートID
        cart.setMember_id(rs.getString("member_id"));     // 会員ID
        cart.setProduct_id(rs.getInt("product_id"));      // 商品ID
        cart.setQuantity(rs.getInt("quantity"));          // 数量
        cart.setCreated_at(rs.getString("created_at"));   // 作成日時
        return cart;                                       // Bean返却
    }
}