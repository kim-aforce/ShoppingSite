<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp -->
<header>
    <!-- 半透明ガラス風ヘッダー -->
    <div class="header-container">
        <!-- ロゴとホーム移動リンク -->
        <h1 class="logo">
            <a style = "color:#FAF9F6"href="${pageContext.request.contextPath}/">Alpha Male</a>
        </h1>

        <!-- ナビゲーションメニュー -->
        <nav>
            <!-- 商品一覧リンク -->
            <a href="${pageContext.request.contextPath}/ProductList">Product List</a>

            <!-- ログイン状態分岐 -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!--ログイン時表示 -->
                    <a href="${pageContext.request.contextPath}/Cart">Cart</a>
                    <a href="${pageContext.request.contextPath}/Logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <!--  非ログイン時表示 -->
                    <a href="${pageContext.request.contextPath}/login-in.jsp">Login</a>
                    <a href="${pageContext.request.contextPath}/user-add.jsp">Register</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>
