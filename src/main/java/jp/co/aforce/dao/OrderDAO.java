package jp.co.aforce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jp.co.aforce.beans.CartBean;
import jp.co.aforce.beans.OrderBean;
import jp.co.aforce.beans.ProductBean;

/**
 * 注文管理DAO
 */
public class OrderDAO extends DAO {
    
    /**
     * 注文作成
     */
    public int createOrder(OrderBean order) throws SQLException {
        String sql = "INSERT INTO orders (member_id, total_amount, order_status, shipping_address) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, order.getMember_id());           // 会員ID設定
            ps.setDouble(2, order.getTotal_amount());        // 合計金額設定
            ps.setString(3, order.getOrder_status());        // 注文状態設定
            ps.setString(4, order.getDelivery_address());    // 配送先住所設定
            
            ps.executeUpdate();                              // INSERT実行
            
            // 生成されたIDを取得
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);                     // 注文ID返却
                }
                throw new SQLException("注文ID生成失敗");
            }
        }
    }
    
    /**
     * 注文商品追加
     */
    public void addOrderItems(int orderId, List<CartBean> cartItems, ProductDAO productDAO) 
            throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            for (CartBean cart : cartItems) {
                // 商品情報取得
                ProductBean product = productDAO.getProductById(cart.getProduct_id());
                if (product != null) {
                    ps.setInt(1, orderId);                   // 注文ID設定
                    ps.setInt(2, cart.getProduct_id());      // 商品ID設定
                    ps.setInt(3, cart.getQuantity());        // 数量設定
                    ps.setDouble(4, product.getPrice());     // 単価設定
                    ps.addBatch();                           // バッチ追加
                }
            }
            ps.executeBatch();                               // バッチ実行
        }
    }
    
    /**
     * 会員別注文一覧取得
     */
    public List<OrderBean> getOrdersByMemberId(String memberId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE member_id = ? ORDER BY order_date DESC";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, memberId);                       // 会員ID設定
            
            try (ResultSet rs = ps.executeQuery()) {
                List<OrderBean> orderList = new ArrayList<>();
                while (rs.next()) {
                    OrderBean order = mapRow(rs);            // ResultSet→Bean変換
                    orderList.add(order);
                }
                return orderList;
            }
        }
    }
    
    /**
     * 単一注文取得
     */
    public OrderBean getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);                           // 注文ID設定
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);                       // Bean返却
                }
                return null;                                 // 未存在時null返却
            }
        }
    }
    
    /**
     * 注文状態更新
     */
    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, status);                         // 新状態設定
            ps.setInt(2, orderId);                           // 注文ID設定
            ps.executeUpdate();                              // UPDATE実行
        }
    }
    
    /**
     * 在庫数減算
     */
    public void updateProductStock(int productId, int quantity) throws SQLException {
        String sql = "UPDATE products SET stock_qty = stock_qty - ? WHERE product_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, quantity);                          // 減算数量設定
            ps.setInt(2, productId);                         // 商品ID設定
            ps.executeUpdate();                              // UPDATE実行
        }
    }
    
    /**
     * ResultSet→OrderBeanマッピング
     */
    private OrderBean mapRow(ResultSet rs) throws SQLException {
        OrderBean order = new OrderBean();
        order.setOrder_id(rs.getInt("order_id"));           // 注文ID
        order.setMember_id(rs.getString("member_id"));      // 会員ID
        order.setTotal_amount(rs.getDouble("total_amount")); // 合計金額
        order.setOrder_status(rs.getString("order_status")); // 注文状態
        order.setOrder_date(rs.getString("order_date"));     // 注文日時
        order.setDelivery_address(rs.getString("shipping_address")); // 配送先住所
        return order;                                        // Bean返却
    }
}