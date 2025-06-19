<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header class="glass header2">
	<div class="header-inner">
		<!-- ロゴとホーム移動リンク -->
		<h1 class="logo">
			<a style="color: #FAF9F6"
				href="${pageContext.request.contextPath}/views/Main/Top.jsp"">AlphaMale</a>
		</h1>
		<nav class="header-nav">
			<c:choose>
				<c:when test="${not empty sessionScope.user}">
					<a class="glass"
						href="${pageContext.request.contextPath}/views/order/OrderHistory.jsp">注文履歴</a>

					<a class="glass"
						href="${pageContext.request.contextPath}/views/user-menu.jsp">会員情報</a>

					<form action="${pageContext.request.contextPath}/logout"
						method="post" style="display: inline;">
						<button type="submit" class="glass logout-btn">Logout</button>
					</form>
				</c:when>
				<c:otherwise>
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
		<form action="ProductList" method="get" class="search-form">
			<input type="text" name="search" placeholder="検索">
			<button type="submit">検索</button>
		</form>
	</div>
</header>
<script>
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.login-form');
    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(form);
            formData.append('ajax', 'true');
            const res = await fetch(form.action, {
                method: 'POST',
                body: formData,
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

    const searchForm = document.querySelector('.search-form');
    const productGrid = document.querySelector('.product-grid');
    if (searchForm && productGrid) {
        searchForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const params = new URLSearchParams(new FormData(searchForm));
            params.append('ajax', 'true');
            const res = await fetch(searchForm.action + '?' + params.toString(), {
                method: 'GET',
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            });
            if (res.ok) {
                const products = await res.json();
                productGrid.innerHTML = '';
                products.forEach(p => {
                    const card = document.createElement('div');
                    card.className = 'product-card glass';
                    card.innerHTML = `
                        <img src="${p.image_url}" alt="${p.product_name}" class="product-img">
                        <h3 style="color: #FAF9F6">${p.product_name}</h3>
                        <p style="color: #FAF9F6">￥${p.price}</p>
                        <a href="ProductDetail?id=${p.product_id}">詳細</a>
                    `;
                    productGrid.appendChild(card);
                });
            }
        });
    }
});
</script>