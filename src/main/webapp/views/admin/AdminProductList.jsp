<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理</title>
	<!-- 管理者用CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
    <script src="${pageContext.request.contextPath}/views/js/admin.js"></script>
</head>
<body>
    <!-- 共通ヘッダー読み込み -->
    <jsp:include page="../common/header2.jsp"/>

    <main class="admin-main">
        <!--  ページタイトル -->
        <h2 class="page-title">商品管理</h2>

        <div class="admin-actions">
            <button id="btn-create" class="action-btn">商品情報登録</button>          <!-- 登録modal trigger -->
            <button id="btn-edit" class="action-btn">商品情報修正</button>            <!--  修正modal trigger-->
            <button id="btn-delete" class="action-btn">商品情報削除</button>          <!-- 削除modal trigger -->
        </div>

        <!-- 商品登録モーダル -->
        <div id="modal-create" class="modal">
            <div class="modal-content glass">
                <span class="close" data-target="modal-create">&times;</span>         <!--modal close btn -->
                <h3>商品情報登録</h3>
                <form action="${pageContext.request.contextPath}/admin/products/new" method="post">
                    <label>商品名 :<input name="product_name" required></label>
                    <label>説明 :<input name="description"></label>
                    <label>価格 :<input type="number" name="price" required></label>
                    <label>カテゴリ :
                        <select name="category_id">
                            <option value="01">衣類</option>
                            <option value="02">靴</option>
                            <option value="03">香水</option>
                            <option value="04">アクセサリー</option>
                            <option value="05">インテリア</option>
                        </select>
                    </label>
                    <label>在庫数 :<input type="number" name="stock_qty" value="10" required></label>
                    <label>画像URL :<input name="image_url" required></label>
                    <button type="submit" class="modal-btn">登録</button>
                </form>
            </div>
        </div>

        <!-- 修正モーダル -->
        <div id="modal-edit" class="modal">
            <div class="modal-content glass">
                <span class="close" data-target="modal-edit">&times;</span>
                <h3>商品情報修正</h3>
                <label>商品選択 :
                    <select id="edit-select"></select>
                </label>
                <form id="form-edit" action="${pageContext.request.contextPath}/admin/products/edit" method="post">
                    <input type="hidden" name="product_id" id="edit-id">
                    <label>商品名 :<input name="product_name" id="edit-name" required></label>
                    <label>説明 :<input name="description" id="edit-desc"></label>
                    <label>価格 :<input type="number" name="price" id="edit-price" required></label>
                    <label>カテゴリ :
                        <select name="category_id" id="edit-cat">
                            <option value="01">衣類</option>
                            <option value="02">靴</option>
                            <option value="03">香水</option>
                            <option value="04">アクセサリー</option>
                            <option value="05">インテリア</option>
                        </select>
                    </label>
                    <label>在庫数 :<input type="number" name="stock_qty" id="edit-stock" required></label>
                    <label>画像URL :<input name="image_url" id="edit-img" required></label>
                    <button type="submit" class="modal-btn">更新</button>
                </form>
            </div>
        </div>

        <!-- 削除モーダル -->
        <div id="modal-delete" class="modal">
            <div class="modal-content glass">
                <span class="close" data-target="modal-delete">&times;</span>
                <h3>商品情報削除</h3>
                <form action="${pageContext.request.contextPath}/admin/products/delete" method="get">
                    <label>商品選択 :
                        <select name="id" id="delete-select"></select>
                    </label>
                    <button type="submit" class="modal-btn">削除</button>
                </form>
            </div>
        </div>

        <script>
            // サーバから渡されたproductsリストをJS配列に変換
            const products = [
                <c:forEach var="p" items="${products}" varStatus="sts">
                    { id:'${p.product_id}', 
                        name:'${p.product_name}', 
                        desc:'${p.description}', 
                        price:${p.price}, 
                        cat:'${p.category_id}', 
                        stock:${p.stock_qty}, 
                        img:'${p.image_url}' }
                    <c:if test="${!sts.last}">,</c:if>
                </c:forEach>
            ];
        </script>
        <script src="${pageContext.request.contextPath}/views/js/admin.js"></script>     <!--管理者用JS -->
    </main>

<jsp:include page="../common/footer.jsp"/>                                             <!-- 共通フッター読み込み -->
</body>
</html>
