<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, jp.co.aforce.beans.ProductBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品一覧</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- ヘッダー挿入 -->
	<jsp:include page="../common/header2.jsp" />

    <main>
        <h2>商品一覧 </h2>

        <!-- 商品グリッド表示 -->
        <div class="product-grid">
            <c:forEach var="product" items="${products}">
                <div class="product-card">
                    <!-- 商品画像 -->
                    <img src="${product.image_url}" alt="${product.product_name}" class="product-img">

                    <!-- 商品名 -->
                    <h3>${product.product_name}</h3>

                    <!-- 商品価格 -->
                    <p>￥${product.price}</p>

                    <!-- 詳細リンク（未実装可） -->
                    <a href="ProductDetail?id=${product.product_id}">詳細</a>
                </div>
            </c:forEach>
        </div>
    </main>
	<jsp:include page="../common/footer2.jsp" />

</body>
</html>
