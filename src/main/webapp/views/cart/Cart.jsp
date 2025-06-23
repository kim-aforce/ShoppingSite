<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カート</title>
<link rel="stylesheet" href="../style/common.css">
<link rel="stylesheet" href="../style/site.css">
<link rel="stylesheet" href="../style/cart.css">
</head>
<body>
	<jsp:include page="../common/header2.jsp" />

	<main>
		<h2>カート</h2>

		<c:if test="${empty cartItems}">
			<div class="empty-cart">
				<p>カートは空です</p>
				<a
					href="${pageContext.request.contextPath}/views/product/ProductList"
					class="btn">商品を見る</a>
			</div>
		</c:if>

		<c:if test="${not empty cartItems}">
			<div class="cart-container">
				<c:forEach var="cart" items="${cartItems}">
					<c:set var="product"
						value="${requestScope['product_'.concat(cart.cart_id)]}" />
					<div class="cart-item">
						<img src="${product.image_url}" alt="${product.product_name}">

						<div class="item-info">
							<h3>${product.product_name}</h3>
							<fmt:formatNumber value="${product.price}" type="number"
								maxFractionDigits="0" groupingUsed="false" var="priceInt" />
							<p>価格: ¥${priceInt}</p>
						</div>

						<div class="quantity-control">
							<form action="${pageContext.request.contextPath}/cart"
								method="post">
								<input type="hidden" name="action" value="update"> <input
									type="hidden" name="cartId" value="${cart.cart_id}"> <input
									type="number" name="quantity" value="${cart.quantity}" min="1"
									max="99">
								<button type="submit">更新</button>
							</form>
						</div>

						<div class="item-total">
							<fmt:formatNumber value="${product.price * cart.quantity}"
								type="number" maxFractionDigits="0" groupingUsed="false"
								var="itemTotal" />
							¥${itemTotal}
						</div>

						<div class="remove-btn">
							<form action="${pageContext.request.contextPath}/cart"
								method="post">
								<input type="hidden" name="action" value="remove"> <input
									type="hidden" name="cartId" value="${cart.cart_id}">
								<button type="submit" onclick="return confirm('削除しますか？')">削除</button>
							</form>
						</div>
					</div>
				</c:forEach>

				<div class="cart-summary">
					<fmt:formatNumber value="${totalAmount}" type="number"
						maxFractionDigits="0" groupingUsed="false" var="totalInt" />
					<h3>合計: ¥${totalInt}</h3>

					<div class="cart-actions">
						<form action="${pageContext.request.contextPath}/cart"
							method="post">
							<input type="hidden" name="action" value="clear">
							<button type="submit" onclick="return confirm('カートを空にしますか？')">カート全削除</button>
						</form>

						<a href="${pageContext.request.contextPath}/order"
							class="btn order-btn">注文する</a>
					</div>
				</div>
			</div>
		</c:if>
	</main>

	<jsp:include page="../common/footer.jsp" />
</body>
</html>