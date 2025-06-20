<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, jp.co.aforce.beans.ProductBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<jsp:include page="../common/header2.jsp" />

    <main>
        <h2 style="color: #FAF9F6">商品一覧 </h2>
        <form action="ProductList" method="get" class="search-form">
			<input type="text" name="search" placeholder="検索">
			<button type="submit">検索</button>
		</form>
        <!-- カテゴリフィルターのみ -->
        <form action="ProductList" method="get" class="search-filter-form">
            <select name="category">
                <option value="">全て</option>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.category_id}" ${c.category_id == param.category ? 'selected' : ''}>${c.category_name}</option>
                </c:forEach>
            </select>
            <button type="submit">絞り込み</button>
        </form>

        <!-- 商品グリッド表示 -->
        <div class="product-grid">
            <c:forEach var="product" items="${products}">
                <div class="product-card glass">
                    <!-- 商品画像 -->
                    <img src="${product.image_url}" alt="${product.product_name}" class="product-img">

                    <!-- 商品名 -->
                    <h3 style="color: #FAF9F6">${product.product_name}</h3>

                    <!-- 商品価格 -->
                    <p style="color: #FAF9F6">￥${product.price}</p>

                    <!-- 詳細リンク（未実装可） -->
                    <a href="ProductDetail?id=${product.product_id}">詳細</a>
                </div>
            </c:forEach>
        </div>
    </main>
	<jsp:include page="../common/footer.jsp" />

</body>
</html>