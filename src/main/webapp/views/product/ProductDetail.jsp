<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<img src="${product.image_url}" alt="${product.product_name}"
					class="product-image">
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
			</div>
				</div>

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
							<!-- 将来的にカート機能実装時に有効化 -->
							<button class="btn btn-disabled" disabled>カートに追加
							</button>
						</c:when>
						<c:otherwise>
							<button class="btn btn-disabled" disabled>在庫切れ</button>
						</c:otherwise>
					</c:choose>

					<a
						href="${pageContext.request.contextPath}/views/product/ProductList"
						class="btn btn-secondary"> 商品一覧に戻る </a>
				</div>

			</div>
		</div>
	</main>

	<!-- フッター挿入 -->
	<jsp:include page="../common/footer.jsp" />
</body>
</html>