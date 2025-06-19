<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="glass header2">
	<div class="header-inner">
		<!-- ロゴとホーム移動リンク -->
		<h1 class="logo">
			<a style="color: #FAF9F6"
				href="${pageContext.request.contextPath}/views/Main/Top.jsp"">AlphaMale</a>
		</h1>
		<nav class="header-nav">
			<a class="glass"
				href="${pageContext.request.contextPath}/views/order/OrderHistory.jsp">注文履歴</a>

			<a class="glass"
				href="${pageContext.request.contextPath}/views/user-menu.jsp">会員情報</a>

			<form action="${pageContext.request.contextPath}/logout"
				method="post" style="display: inline;">
				<button type="submit" class="glass logout-btn">ログアウト</button>
			</form>
		</nav>
		<form action="ProductList" method="get" class="search-form">
			<input type="text" name="search" placeholder="検索">
			<button type="submit">検索</button>
		</form>
	</div>
</header>