<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- header.jsp -->

<header>
	<!-- 半透明ガラス風ヘッダー -->
	<div class="header-container">
		<!-- ロゴとホーム移動リンク -->
		<h1 class="logo">
			<a style="color: #FAF9F6"
				href="${pageContext.request.contextPath}/views/Main/Top.jsp"">Alpha
				Male</a>
		</h1>

		<!-- ナビゲーションメニュー -->
		<nav>
			<!-- 商品一覧リンク -->
			<a class="glass" href="${pageContext.request.contextPath}
			/views/product/ProductList">ProductList</a>

			<!-- ログイン状態分岐 -->
			<c:choose>
				<c:when test="${not empty sessionScope.user}">
					<!--ログイン時表示 -->
					<a class="glass" href="${pageContext.request.contextPath}/Cart">Cart</a>
					<a class="glass" id="logout-link"
						href="${pageContext.request.contextPath}/logout">Logout</a>
				</c:when>

				<c:otherwise>
					<!--  非ログイン時表示 -->
					<form action="${pageContext.request.contextPath}/views/login"
						method="post" class="login-form">
						<input type="text" name="id" placeholder="ID"> <input
							type="password" name="pw" placeholder="PW">
						<button type="submit" class="glass">Login</button>
					</form>
					<a class="glass"
						href="${pageContext.request.contextPath}/views/user-add.jsp">Register</a>
				</c:otherwise>
			</c:choose>
		</nav>
	</div>
</header>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.login-form');
    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const data = new FormData(form);
            data.append('ajax', 'true');
            const params = new URLSearchParams(data);
            
            const res = await fetch(form.action, {
                method: 'POST',
                body: params,
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            });
            if (res.ok) {
                const result = await res.json();
                if (result.status === 'success') {
                    location.reload();
                } else {
                    alert('ログインに失敗しました');
                }
            }
        });
    }
    const logoutLink = document.querySelector('#logout-link');
    if (logoutLink) {
        logoutLink.addEventListener('click', async (e) => {
            e.preventDefault();
            const params = new URLSearchParams();
            params.append('ajax', 'true');
            const res = await fetch(logoutLink.href, {
                method: 'POST',
                body: params,
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            });
            if (res.ok) {
                const result = await res.json();
                if (result.status === 'success') {
                    location.reload();
                } else {
                    alert('ログアウトに失敗しました');
                }
            }
        });
    }
});
</script>
