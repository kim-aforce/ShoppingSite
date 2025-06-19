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
    </head>
<body>

    <!-- ヘッダー挿入 -->
	<jsp:include page="../common/header2.jsp" />

    <main>
        <h2>商品一覧 </h2>

        <form method="get" action="ProductList" class="sort-form">
            <select name="sort" onchange="this.form.submit()">
                <option value="">デフォルト</option>
                <option value="price" ${param.sort == 'price' ? 'selected' : ''}>価格順</option>
                <option value="name" ${param.sort == 'name' ? 'selected' : ''}>商品名順</option>
                <option value="category" ${param.sort == 'category' ? 'selected' : ''}>カテゴリ順</option>
            </select>
            <c:if test="${not empty param.category}">
                <input type="hidden" name="category" value="${param.category}" />
            </c:if>
            <c:if test="${not empty param.search}">
                <input type="hidden" name="search" value="${param.search}" />
            </c:if>
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
