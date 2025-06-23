<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文フォーム</title>
<link rel="stylesheet" href="../style/common.css">
<link rel="stylesheet" href="../style/site.css">
<link rel="stylesheet" href="../style/order.css">
</head>
<body>
    <jsp:include page="../common/header2.jsp" />
    
    <main class="order-container">
        <div class="step-bar">Step1. Cart ▶ Step2. Order ▶ Step3. Order Confirmed</div>
        
        <form action="${pageContext.request.contextPath}/order" method="post">
            <div class="order-layout">
                <!-- 配送情報 -->
                <div class="shipping-section">
                    <h3>配送情報</h3>
                    <div class="form-group">
                        <label>宛名</label>
                        <input type="text" value="${user.lastname} ${user.firstname}" readonly>
                    </div>
                    <div class="form-group">
                        <label>配送先住所</label>
                        <input type="text" name="shippingAddress" value="${user.address}" required>
                    </div>
                    <div class="form-group">
                        <label>連絡先</label>
                        <input type="email" value="${user.mailAddress}" readonly>
                    </div>
                </div>
                
                <!-- 支払方法 -->
                <div class="payment-section">
                    <h3>お支払方法</h3>
                    <div class="payment-options">
                        <label>
                            <input type="radio" name="payment" value="credit" checked>
                            クレジットカード
                        </label>
                        <label>
                            <input type="radio" name="payment" value="bank">
                            口座振込
                        </label>
                        <label>
                            <input type="radio" name="payment" value="later">
                            後払い
                        </label>
                    </div>
                </div>
            </div>
            
            <!-- 注文商品 -->
            <div class="order-items">
                <h3>注文商品</h3>
                <c:forEach var="cart" items="${cartItems}">
                    <c:set var="product" value="${requestScope['product_'.concat(cart.cart_id)]}" />
                    <div class="order-item">
                        <img src="${product.image_url}" alt="${product.product_name}">
                        <div class="item-details">
                            <h4>${product.product_name}</h4>
                            <p>数量: ${cart.quantity}</p>
                            <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="false" var="priceInt" />
                            <p>価格: ¥${priceInt}</p>
                            <fmt:formatNumber value="${product.price * cart.quantity}" type="number" maxFractionDigits="0" groupingUsed="false" var="itemTotal" />
                            <p class="item-subtotal">小計: ¥${itemTotal}</p>
                        </div>
                    </div>
                </c:forEach>
                
                <div class="order-total">
                    <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0" groupingUsed="false" var="totalInt" />
                    <h3>合計金額: ¥${totalInt}</h3>
                </div>
            </div>
            
            <div class="order-actions">
                <button type="submit" class="order-confirm-btn">注文確定</button>
            </div>
        </form>
    </main>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>