<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品一覧</title>
</head>
<body>
<!-- ヘッダー挿入 -->
    <jsp:include page="../common/header2.jsp" />

    <div class="main-container">
        <!-- カテゴリサイドバー -->
        <aside class="category-sidebar">
            <h3 class="category-title">カテゴリ</h3>
            <ul class="category-list">
                <li class="category-item">
                    <a href="ProductList" class="category-link ${empty param.category ? 'active' : ''}">
                        全て
                    </a>
                </li>
                <li class="category-item">
                    <a href="ProductList?category=01" class="category-link ${param.category == '01' ? 'active' : ''}">
                        衣類
                    </a>
                </li>
                <li class="category-item">
                    <a href="ProductList?category=02" class="category-link ${param.category == '02' ? 'active' : ''}">
                        香水
                    </a>
                </li>
                <li class="category-item">
                    <a href="ProductList?category=03" class="category-link ${param.category == '03' ? 'active' : ''}">
                        靴
                    </a>
                </li>
                <li class="category-item">
                    <a href="ProductList?category=04" class="category-link ${param.category == '04' ? 'active' : ''}">
                        アクセサリー
                    </a>
                </li>
                <li class="category-item">
                    <a href="ProductList?category=05" class="category-link ${param.category == '05' ? 'active' : ''}">
                        インテリア
                    </a>
                </li>
            </ul>
        </aside>

        <!-- メインコンテンツエリア -->
        <main class="content-area">
            <!-- ページヘッダー -->
            <div class="page-header">
                <h2 class="page-title">
                    <c:choose>
                        <c:when test="${not empty param.search}">
                            "${param.search}" 검색결과
                        </c:when>
                        <c:when test="${param.category == '01'}">衣류</c:when>
                        <c:when test="${param.category == '02'}">香水</c:when>
                        <c:when test="${param.category == '03'}">靴</c:when>
                        <c:when test="${param.category == '04'}">アクセサリー</c:when>
                        <c:when test="${param.category == '05'}">インテリア</c:when>
                        <c:otherwise>商品一覧</c:otherwise>
                    </c:choose>
                </h2>
                
                <!-- 검색 폼 -->
                <div class="search-container">
                    <form action="ProductList" method="get" style="display: flex; gap: 10px;">
                        <input type="text" 
                               name="search" 
                               value="${param.search}" 
                               placeholder="商品を検索..." 
                               class="search-input">
                        <button type="submit" class="search-btn">検索</button>
                    </form>
                </div>
            </div>

            <!-- 商品グリッド表示 -->
            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card glass">
                                <!-- 商品画像 -->
                                <img src="${product.image_url}" alt="${product.product_name}" class="product-img">

                                <!-- 商品情報 -->
                                <h3 class="product-name">${product.product_name}</h3>
                                <p class="product-price">￥${product.price}</p>

                                <!-- アクションボタン -->
                                <div class="product-actions">
                                    <a href="ProductDetail?id=${product.product_id}" class="btn btn-detail">詳細</a>
                                    <c:choose>
                                        <c:when test="${product.stock_qty > 0}">
                                            <button class="btn btn-cart" onclick="addToCart(${product.product_id})">
                                                カートに追加
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-cart" disabled style="opacity: 0.5;">
                                                売切れ
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1 / -1; text-align: center; color: #FAF9F6; padding: 50px;">
                            <h3>商品が見つかりません</h3>
                            <c:if test="${not empty param.search}">
                                <p>"${param.search}"に該当する商品がありません</p>
                            </c:if>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <jsp:include page="../common/footer.jsp" />