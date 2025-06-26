<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文フォーム</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/site.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/order.css">
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<main class="order-container">
		<div class="step-bar">
			<span class="step-inactive">Step1. Cart</span> ▶ <span
				class="step-active">Step2. Order</span> ▶ <span
				class="step-inactive">Step3. Order Confirmed</span>
		</div>

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
						<label>郵便番号 (-なしで入力)</label> 
						<input type="text" id="zipcode" placeholder="1234567" maxlength="7" style="width: 150px;">
					</div>
					
					<div class="form-group">
						<label>都道府県</label> 
						<input type="text" id="prefecture" style="background: rgba(255,255,255,0.1);">
					</div>
					
					<div class="form-group">
						<label>市区町村</label> 
						<input type="text" id="city" style="background: rgba(255,255,255,0.1);">
					</div>
					
					<div class="form-group">
						<label>町域番地</label> 
						<input type="text" id="town" style="background: rgba(255,255,255,0.1);">
					</div>
					
					<div class="form-group">
						<label>建物名・部屋番号</label> 
						<input type="text" id="detail" name="shippingAddress" placeholder="マンション名、部屋番号など" required>
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
						<label> <input type="radio" name="payment" value="credit" checked> クレジットカード</label> 
						<label> <input type="radio" name="payment" value="bank"> 口座振込</label> 
						<label> <input type="radio" name="payment" value="later"> 後払い</label>
					</div>
				</div>
			</div>

			<!-- 注文商品 -->
			<div class="order-items">
				<h3>注文商品</h3>
				<c:forEach var="cart" items="${cartItems}">
					<c:set var="product" value="${requestScope['product_'.concat(cart.cart_id)]}" />
					<div class="order-item">

						<c:set var="imagePath"
							value="${fn:replace(cart.image_url, '../img/', '/views/img/')}" />
						<img src="${pageContext.request.contextPath}${imagePath}"
							alt="${cart.product_name}" />

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
	
	<script src="${pageContext.request.contextPath}/views/js/zipcode.js"></script>
	
</body>
</html>