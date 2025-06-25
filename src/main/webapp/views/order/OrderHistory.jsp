<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文履歴</title>
<link rel="stylesheet" href="../style/common.css">
<link rel="stylesheet" href="../style/site.css">
<link rel="stylesheet" href="../style/order-history.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <main class="order-history-container">
        <h2>注文履歴</h2>
        
        <c:if test="${empty orderList}">
            <div class="empty-orders">
                <p>注文履歴がありません</p>
                <a href="${pageContext.request.contextPath}/views/product/ProductList" class="btn">商品を見る</a>
            </div>
        </c:if>
        
        <c:if test="${not empty orderList}">
            <div class="orders-list">
                <c:forEach var="order" items="${orderList}">
                    <div class="order-card glass">
                        <div class="order-header">
                            <div class="order-info">
                                <h3>注文番号: ${order.order_id}</h3>
                                <p class="order-date">注文日時: ${order.order_date}</p>
                            </div>
                            <div class="order-status">
                                <span class="status-badge status-${order.order_status}">
                                    <c:choose>
                                        <c:when test="${order.order_status == 'PENDING'}">処理中</c:when>
                                        <c:when test="${order.order_status == 'SHIPPED'}">発送済み</c:when>
                                        <c:when test="${order.order_status == 'DELIVERED'}">配送完了</c:when>
                                        <c:when test="${order.order_status == 'CANCELLED'}">キャンセル</c:when>
                                        <c:otherwise>${order.order_status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                        
                        <div class="order-details">
                            <div class="delivery-address">
                                <strong>配送先:</strong> ${order.delivery_address}
                            </div>
                            
                            <div class="order-total">
                                <fmt:formatNumber value="${order.total_amount}" type="number" 
                                    maxFractionDigits="0" groupingUsed="false" var="totalInt" />
                                <strong>合計金額: ¥${totalInt}</strong>
                            </div>
                        </div>
                        
                        <div class="order-actions">
                            <button class="btn btn-secondary" 
                                    onclick="toggleOrderItems(${order.order_id})">
                                注文詳細を見る
                            </button>
                            
                            <c:if test="${order.order_status == 'PENDING'}">
                                <button class="btn btn-cancel" 
                                        onclick="cancelOrder(${order.order_id})">
                                    注文キャンセル
                                </button>
                            </c:if>
                        </div>
                        
                        <!-- 注文商品詳細（初期非表示） -->
                        <div id="order-items-${order.order_id}" class="order-items" style="display: none;">
                            <h4>注文商品詳細</h4>
                            <div class="items-loading">
                                <p>商品詳細を読み込み中...</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <div class="history-actions">
            <a href="${pageContext.request.contextPath}/views/Main/Top.jsp" 
               class="btn btn-primary">TOPページへ</a>
            <a href="${pageContext.request.contextPath}/views/product/ProductList" 
               class="btn btn-secondary">商品一覧へ</a>
        </div>
    </main>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script>
    // 注文詳細表示切り替え
    function toggleOrderItems(orderId) {
        const itemsDiv = document.getElementById('order-items-' + orderId);
        if (itemsDiv.style.display === 'none') {
            itemsDiv.style.display = 'block';
            // 実際のプロジェクトでは AJAX で order_items テーブルから詳細取得
            // 現在は簡易表示
            setTimeout(() => {
                itemsDiv.innerHTML = `
                    <h4>注文商品詳細</h4>
                    <p style="color: #FAF9F6; padding: 1rem;">
                        ※商品詳細情報の表示機能は次のフェーズで実装予定です。<br>
                        現在は注文の基本情報のみ表示しています。
                    </p>
                `;
            }, 500);
        } else {
            itemsDiv.style.display = 'none';
        }
    }
    
    // 注文キャンセル
    function cancelOrder(orderId) {
        if (confirm('注文をキャンセルしますか？')) {
            // 実際のプロジェクトでは AJAX でキャンセル処理
            alert('キャンセル機能は次のフェーズで実装予定です。');
        }
    }
    </script>
</body>
</html>