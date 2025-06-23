<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カート</title>
<!-- CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/cart.css">
</head>
<body>
    <jsp:include page="../common/header2.jsp" />
    
    <main>
        <c:if test="${empty cartItems}">
            <div class="empty-cart">
                <p>カートは空です</p>
                <a href="${pageContext.request.contextPath}/views/product/ProductList" class="btn">商品を見る</a>
            </div>
        </c:if>
        
        <c:if test="${not empty cartItems}">
            <div class="cart-container">
                <!-- Step indicator -->
                <div class="step-bar">
                    <span class="step-active">Step1. Cart</span> ▶ 
                    <span class="step-inactive">Step2. Order</span> ▶ 
                    <span class="step-inactive">Step3. Order Confirmed</span>
                </div>
                
                <div class="cart-header">
                    <div>選択</div>
                    <div>商品情報</div>
                    <div>数量</div>
                    <div>注文金額</div>
                    <div>削除</div>
                </div>
                
                <c:forEach var="cart" items="${cartItems}">
                    <c:set var="product" value="${requestScope['product_'.concat(cart.cart_id)]}" />
                    <div class="cart-item">
                        <input type="checkbox" name="cartCheck" value="${cart.cart_id}" />
                        
                        <div class="item-info">
                            <!-- イメージ表示修正 -->
                            <img src="${not empty product.image_url ? product.image_url : '/views/img/default-product.png'}" 
                                 alt="${product.product_name}" 
                                 onerror="this.src='${pageContext.request.contextPath}/views/img/default-product.png'">
                            <div class="item-details">
                                <h3>${product.product_name}</h3>
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="false" var="priceInt" />
                                <p>価格: ¥${priceInt}</p>
                            </div>
                        </div>
                        
                        <div class="quantity-controls">
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="cartId" value="${cart.cart_id}">
                                <input type="hidden" name="quantity" value="${cart.quantity - 1}">
                                <button type="submit" class="qty-btn" ${cart.quantity <= 1 ? 'disabled' : ''}>−</button>
                            </form>
                            <span class="quantity">${cart.quantity}</span>
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="cartId" value="${cart.cart_id}">
                                <input type="hidden" name="quantity" value="${cart.quantity + 1}">
                                <button type="submit" class="qty-btn">＋</button>
                            </form>
                        </div>
                        
                        <div class="item-total">
                            <fmt:formatNumber value="${product.price * cart.quantity}" type="number" maxFractionDigits="0" groupingUsed="false" var="itemTotal" />
                            ¥${itemTotal}
                        </div>
                        
                        <div class="remove-btn">
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="cartId" value="${cart.cart_id}">
                                <button type="submit" onclick="return confirm('削除しますか？')">×</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                
                <div class="cart-actions">
                    <a href="${pageContext.request.contextPath}/views/product/ProductList" class="continue-shopping">買い物を続く</a>
                    <a href="${pageContext.request.contextPath}/order" class="order-btn">注文する</a>
                </div>
            </div>
        </c:if>
    </main>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>