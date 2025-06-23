<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品詳細 - ${product.product_name}</title>
<link rel="stylesheet" href="../style/common.css">
<link rel="stylesheet" href="../style/site.css">
<link rel="stylesheet" href="../style/product-detail.css">
</head>
<body>
	<!-- ヘッダー挿入 -->
	<jsp:include page="../common/header2.jsp" />

	<main class="product-detail-container">
		<div class="product-detail-grid">
			<!-- 商品画像 -->
			<div class="image-section">
				<a href="${product.image_url}" target="_blank"> <img
					src="${product.image_url}" alt="${product.product_name}"
					class="product-image">
				</a>
			</div>

			<!-- 商品情報 -->
			<div class="product-info">
				<h1>${product.product_name}</h1>

				<div class="product-description">${product.description}</div>

				<!-- 価格セクション -->
				<fmt:formatNumber value="${product.price}" type="number"
					maxFractionDigits="0" groupingUsed="false" var="priceInt" />

				<div class="price-main">¥ ${priceInt}</div>

				<fmt:formatNumber value="${priceWithTax}" type="number"
					maxFractionDigits="0" groupingUsed="false" var="priceTaxInt" />

				<div class="price-tax">税込 ¥ ${priceTaxInt}</div>

				<!-- 在庫情報 -->
				<div class="stock-info">
					在庫:
					<c:choose>
						<c:when test="${product.stock_qty > 0}">
							<span class="stock-available">在庫あり (${product.stock_qty}個)</span>
						</c:when>
						<c:otherwise>
							<span class="stock-unavailable">在庫切れ</span>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- アクションボタン -->
				<div class="action-buttons">
					<c:choose>
						<c:when test="${product.stock_qty > 0}">
							<c:choose>
								<c:when test="${not empty sessionScope.user}">
									<form action="${pageContext.request.contextPath}/cart"
										method="post" style="display: inline;">
										<input type="hidden" name="action" value="add"> <input
											type="hidden" name="productId" value="${product.product_id}">
										<input type="number" name="quantity" value="1" min="1"
											max="${product.stock_qty}"
											style="width: 60px; margin-right: 10px;">
										<button type="submit" class="btn btn-primary">カートに追加</button>
									</form>
								</c:when>
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/views/login-in.jsp"
										class="btn btn-primary">ログインしてカートに追加</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<button class="btn btn-disabled" disabled>在庫切れ</button>
						</c:otherwise>
					</c:choose>

					<a
						href="${pageContext.request.contextPath}/views/product/ProductList"
						class="btn btn-secondary">商品一覧に戻る</a>
				</div>

			</div>
		</div>
	</main>

	<!-- フッター挿入 -->
	<jsp:include page="../common/footer.jsp" />
</body>
</html>