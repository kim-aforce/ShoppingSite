<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
</head>
<body>
<jsp:include page="../common/header2.jsp" />

<main class="cart-container">
    <div class="step-bar">Step1. Cart ▶ Step2. Order ▶ Step3. Order Confirmed</div>

    <c:if test="${not empty cartList}">
        <div class="cart-items">
            <c:forEach var="item" items="${cartList}">
                <div class="cart-item">
                    <input type="checkbox" name="cartCheck" value="${item.id}" />
                    <div class="item-info">
                        <img src="${item.imageUrl}" alt="${item.name}">
                        <div class="info-text">
                            <p class="name">${item.name}</p>
                            <p class="price">
                                <fmt:formatNumber value="${item.price}" type="currency" />
                            </p>
                        </div>
                    </div>
                    <div class="quantity-control">
                        <button class="minus">-</button>
                        <input type="text" value="${item.quantity}"/>
                        <button class="plus">+</button>
                    </div>
                    <div class="item-total">
                        <fmt:formatNumber value="${item.subtotal}" type="currency"/>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <div class="cart-actions">
        <a href="${pageContext.request.contextPath}/views/product/ProductList" class="continue">買い物を続ける</a>
        <a href="${pageContext.request.contextPath}/order" class="order-btn">注文する</a>
    </div>
</main>

<jsp:include page="../common/footer.jsp" />
</body>
</html>