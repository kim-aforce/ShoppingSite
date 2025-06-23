<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<div class="price-section">
					<div class="price-main">
						¥
						<c:out value="${product.price}" />
					</div>
					<div class="price-tax">
						消費税10％込み ¥
						<c:out value="${priceWithTax}" />
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
							<button class="btn btn-disabled" disabled>カートに追加 (近日対応)
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

				<!-- 商品情報詳細 -->
				<div class="product-details"
					style="color: #FAF9F6; font-size: 0.9rem; opacity: 0.8;">
					<p>商品ID: ${product.product_id}</p>
					<p>カテゴリ: ${product.category_id}</p>
				</div>
			</div>
		</div>
	</main>

	<!-- フッター挿入 -->
	<jsp:include page="../common/footer.jsp" />
</body>
</html>