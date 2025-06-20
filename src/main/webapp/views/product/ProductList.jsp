<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品一覧</title>
    <link rel="stylesheet" href="../style/product.css">
</head>
<body>
    <jsp:include page="../common/header2.jsp"/>
    <h2 class="page-title">商品一覧</h2>
    <div class="content-wrapper">
        <aside class="category-filter">
            <ul>
                <li>衣類</li>
                <li>靴</li>
                <li>香水</li>
                <li>アクセサリー</li>
                <li>インテリア</li>
            </ul>
        </aside>
        <section class="product-grid">
            <c:forEach var="product" items="${products}">
                <div class="product-card">
                    <div class="image-container">
                        <img src="<c:url value='${product.image_url}'/>" alt="${product.product_name}">
                    </div>
                    <div class="product-info">
                        <p class="product-name">${product.product_name}</p>
                        <p class="product-price">￥${product.price}</p>
                    </div>
                </div>
            </c:forEach>
        </section>
    </div>
    <jsp:include page="../common/footer2.jsp"/>
</body>
</html>
