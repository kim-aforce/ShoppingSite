<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理フォーム</title>
    <!-- 共有Glassmorphismスタイル -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/Top.css">
    <!-- 管理者用スタイル -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/admin.css">
</head>
<body>
    <!-- 共通ヘッダー読み込み -->
    <jsp:include page="../common/header2.jsp"/>

    <!-- フォームコンテナ -->
    <main class="admin-form-container glass">
        <!-- フォームタイトル表示 -->
        <h2>
            <c:choose>
                <c:when test="${mode == 'new'}">商品情報登録</c:when>
                <c:otherwise>商品情報修正</c:otherwise>
            </c:choose>
        </h2>

        <!-- 新規登録/編集送信フォーム -->
        <form action="${pageContext.request.contextPath}/admin/products/${mode}" method="post">
            <!-- 編集時のみIDを送信 -->
            <c:if test="${mode == 'edit'}">
                <input type="hidden" name="product_id" value="${product.product_id}"/>
            </c:if>

            <!-- 商品名入力フィールド -->
            <div class="form-field">
                <label>商品名:
                    <input type="text" name="product_name" value="${product.product_name}" required/>
                </label>
            </div>

            <!-- 説明入力フィールド -->
            <div class="form-field">
                <label>説明:
                    <input type="text" name="description" value="${product.description}"/>
                </label>
            </div>

            <!-- 価格入力フィールド -->
            <div class="form-field">
                <label>価格:
                    <input type="number" name="price" value="${product.price}" required/>
                </label>
            </div>

            <!-- カテゴリ選択フィールド -->
            <div class="form-field">
                <label>カテゴリ:
                    <select name="category_id">
                        <option value="01" <c:if test="${product.category_id=='01'}">selected</c:if>>衣類</option>
                        <option value="02" <c:if test="${product.category_id=='02'}">selected</c:if>>靴</option>
                        <option value="03" <c:if test="${product.category_id=='03'}">selected</c:if>>香水</option>
                        <option value="04" <c:if test="${product.category_id=='04'}">selected</c:if>>アクセサリー</option>
                        <option value="05" <c:if test="${product.category_id=='05'}">selected</c:if>>インテリア</option>
                    </select>
                </label>
            </div>

            <!-- 在庫数入力フィールド -->
            <div class="form-field">
                <label>在庫数:
                    <input type="number" name="stock_qty" value="${product.stock_qty}" required/>
                </label>
            </div>

            <!-- 画像URL入力フィールド -->
            <div class="form-field">
                <label>画像URL:
                    <input type="text" name="image_url" value="${product.image_url}" required/>
                </label>
            </div>

            <!-- 送信ボタン -->
            <div class="form-actions">
                <button type="submit">
                    <c:choose>
                        <c:when test="${mode == 'new'}">登録</c:when>
                        <c:otherwise>更新</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </main>

    <!-- 共通フッター読み込み -->
    <jsp:include page="../footer.jsp"/>
</body>
</html>
