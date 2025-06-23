<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理フォーム</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/Top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
</head>
<body>
    <jsp:include page="../common/header2.jsp"/>

    <main class="admin-form-container glass">
        <h2>
            <c:choose>
                <c:when test="${mode == 'new'}">商品情報登録</c:when>
                <c:otherwise>商品情報修正</c:otherwise>
            </c:choose>
        </h2>

        <
        <c:if test="${mode == 'edit'}">
            <p>編集中の商品 ID: ${product.product_id}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/products/${mode}" method="post">
            <c:if test="${mode == 'edit'}">
                <input type="hidden" name="product_id" value="${product.product_id}"/>
            </c:if>

            <div class="form-field">
                <label>商品名:
                    <input type="text" name="product_name" value="${product.product_name}" required/>
                </label>
            </div>

            <div class="form-field">
                <label>説明:
                    <textarea name="description" rows="3">${product.description}</textarea>
                </label>
            </div>

            <!-- 価格表示 -->
            <div class="form-field">
                <label>価格:
                    <c:choose>
                        <c:when test="${product.price != null && product.price > 0}">
                            <fmt:formatNumber value="${product.price}" type="number" 
                                            maxFractionDigits="0" groupingUsed="false" var="priceInt" />
                            <input type="number" name="price" value="${priceInt}" required/>
                        </c:when>
                        <c:otherwise>
                            <input type="number" name="price" value="" required/>
                        </c:otherwise>
                    </c:choose>
                </label>
            </div>

            <div class="form-field">
                <label>カテゴリ:
                    <select name="category_id" required>
                        <option value="">カテゴリ選択</option>
                        <option value="01" <c:if test="${product.category_id=='01'}">selected</c:if>>衣類</option>
                        <option value="02" <c:if test="${product.category_id=='02'}">selected</c:if>>靴</option>
                        <option value="03" <c:if test="${product.category_id=='03'}">selected</c:if>>香水</option>
                        <option value="04" <c:if test="${product.category_id=='04'}">selected</c:if>>アクセサリー</option>
                        <option value="05" <c:if test="${product.category_id=='05'}">selected</c:if>>インテリア</option>
                    </select>
                </label>
            </div>

            <div class="form-field">
                <label>在庫数:
                    <input type="number" name="stock_qty" value="${product.stock_qty}" min="0" required/>
                </label>
            </div>

            <div class="form-field">
                <label>画像URL:
                    <input type="url" name="image_url" value="${product.image_url}" 
                           placeholder="https://example.com/image.jpg" required/>
                </label>
                <!-- Image Preview -->
                <c:if test="${not empty product.image_url}">
                    <div class="image-preview">
                        <img src="${product.image_url}" alt="Preview" style="max-width: 100px; max-height: 100px; margin-top: 10px;">
                    </div>
                </c:if>
            </div>

            <div class="form-actions">
                <button type="submit">
                    <c:choose>
                        <c:when test="${mode == 'new'}">登録</c:when>
                        <c:otherwise>更新</c:otherwise>
                    </c:choose>
                </button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn-cancel">戻る</a>
            </div>
        </form>
    </main>

    <jsp:include page="../common/footer.jsp"/>
</body>
</html>