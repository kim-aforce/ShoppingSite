<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, jp.co.aforce.beans.ProductBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品一覧</title>
<link rel="stylesheet" href="../style/common.css">
<link rel="stylesheet" href="../style/product.css">
<link rel="stylesheet" href="../style/site.css">
</head>
<body>

	<!-- ヘッダー挿入 -->
	<jsp:include page="../common/header.jsp" />

	<main>
		<h2 class = "h2-layout" style="color: #FAF9F6">商品一覧</h2>
		<form action="ProductList" method="get" class="search-form">
			<input type="text" name="search" placeholder="検索"
				value="${param.search}"> <select name="category">
				<option style = "color : #FAF9F6" value="">全て</option>
				<c:forEach var="c" items="${categories}">
					<option value="${c.category_id}"
						${c.category_id == param.category ? 'selected' : ''}>${c.category_name}</option>
				</c:forEach>
			</select> <select name="sort">
				<option style = "color : #FAF9F6" value="">並び替え</option>
				<option value="price_asc"
					${param.sort == 'price_asc' ? 'selected' : ''}>価格が安い順</option>
				<option value="price_desc"
					${param.sort == 'price_desc' ? 'selected' : ''}>価格が高い順</option>
				<option value="name_asc"
					${param.sort == 'name_asc' ? 'selected' : ''}>商品名順</option>
			</select>
			<button type="submit">検索</button>
		</form>

		<!-- 商品グリッド表示 -->
		<div class="product-grid">
			<c:forEach var="product" items="${products}">
				<div class="product-card glass">
					<!-- 商品画像 -->
					<a href="ProductDetail?id=${product.product_id}"> <img
						src="${product.image_url}" alt="${product.product_name}"
						class="product-img">
					</a>

					<!-- 商品名 -->
					<h3 style="color: #FAF9F6">${product.product_name}</h3>

					<!-- 商品価格 -->
					<fmt:formatNumber value="${product.price}" type="number"
						maxFractionDigits="0" groupingUsed="false" var="priceInt" />

					<p style="color: #FAF9F6">￥${priceInt}</p>
				</div>
			</c:forEach>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />

</body>
</html>