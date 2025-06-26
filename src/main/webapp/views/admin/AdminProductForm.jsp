<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品管理フォーム</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/Top.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/admin.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/admin-upload.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/admin-form.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/style/site.css">

</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<main class="admin-form-container glass">
		<h2>
			<c:choose>
				<c:when test="${mode == 'new'}">商品情報登録</c:when>
				<c:otherwise>商品情報修正</c:otherwise>
			</c:choose>
		</h2>

		<c:if test="${mode == 'edit'}">
			<p>編集中の商品 ID: ${product.product_id}</p>
		</c:if>

		<form
			action="${pageContext.request.contextPath}/admin/products/${mode}"
			method="post" id="productForm">
			<c:if test="${mode == 'edit'}">
				<input type="hidden" name="product_id" value="${product.product_id}" />
			</c:if>

			<div class="form-field">
				<label>商品名: <input type="text" name="product_name"
					value="${product.product_name}" required />
				</label>
			</div>

			<div class="form-field">
				<label>説明: <textarea name="description" rows="3">${product.description}</textarea>
				</label>
			</div>

			<!-- 価格表示 -->
			<div class="form-field">
				<label>価格: <c:choose>
						<c:when test="${product.price != null && product.price > 0}">
							<fmt:formatNumber value="${product.price}" type="number"
								maxFractionDigits="0" groupingUsed="false" var="priceInt" />
							<input type="number" name="price" value="${priceInt}" required />
							s
						</c:when>
						<c:otherwise>
							<input type="number" name="price" value="" required />
						</c:otherwise>
					</c:choose>
				</label>
			</div>

			<div class="form-field">
				<label>カテゴリ: <select name="category_id" required>
						<option value="">カテゴリ選択</option>
						<option value="01"
							<c:if test="${product.category_id=='01'}">selected</c:if>>衣類</option>
						<option value="02"
							<c:if test="${product.category_id=='02'}">selected</c:if>>靴</option>
						<option value="03"
							<c:if test="${product.category_id=='03'}">selected</c:if>>香水</option>
						<option value="04"
							<c:if test="${product.category_id=='04'}">selected</c:if>>アクセサリー</option>
						<option value="05"
							<c:if test="${product.category_id=='05'}">selected</c:if>>インテリア</option>
				</select>
				</label>
			</div>

			<div class="form-field">
				<label>在庫数: <input type="number" name="stock_qty"
					value="${product.stock_qty}" min="0" required />
				</label>
			</div>

			<!-- 新しい画像アップロードセクション -->
			<div class="form-field">
				<label>商品画像:</label>

				<!-- ドラッグ&ドロップアップロードエリア -->
				<div class="upload-area" id="uploadArea">
					<div class="upload-content">
						<div class="upload-icon">📁</div>
						<p class="upload-text">画像ファイルをドラッグ&ドロップ</p>
						<p class="upload-subtext">または</p>
						<button type="button" class="upload-btn" id="selectFileBtn">ファイルを選択</button>
						<p class="upload-info">対応形式: JPG, PNG, GIF, WebP (最大10MB)</p>
					</div>
				</div>

				<!-- 非表示ファイル入力 -->
				<input type="file" id="fileInput" accept="image/*"
					style="display: none;">

				<!-- アップロード進行状態 -->
				<div class="upload-progress" id="uploadProgress"
					style="display: none;">
					<div class="progress-bar">
						<div class="progress-fill" id="progressFill"></div>
					</div>
					<p class="progress-text" id="progressText">アップロード中...</p>
				</div>

				<!-- 画像プレビュー -->
				<div class="image-preview-container" id="previewContainer"
					style="display: none;">
					<div class="image-preview">
						<img id="previewImage" src="" alt="Preview">
						<div class="image-info">
							<p class="file-name" id="previewFileName"></p>
							<p class="file-size" id="previewFileSize"></p>
						</div>
						<button type="button" class="remove-image-btn" id="removeImageBtn">❌
							削除</button>
					</div>
				</div>

				<!-- 既存画像表示（編集モード） -->
				<c:if test="${mode == 'edit' && not empty product.image_url}">
					<div class="current-image">
						<p>現在の画像:</p>
						<img src="${product.image_url}" alt="Current Image"
							class="current-image-display">
					</div>
				</c:if>

				<!-- 非表示画像URLフィールド -->
				<input type="hidden" name="image_url" id="imageUrlField"
					value="${product.image_url}" />
			</div>

			<div class="form-actions">
				<button type="submit" id="submitBtn">
					<c:choose>
						<c:when test="${mode == 'new'}">登録</c:when>
						<c:otherwise>更新</c:otherwise>
					</c:choose>
				</button>
				<a href="${pageContext.request.contextPath}/admin/products"
					class="btn-cancel">戻る</a>
			</div>
		</form>
	</main>

	<jsp:include page="../common/footer.jsp" />

	<script
		src="${pageContext.request.contextPath}/views/js/admin-upload.js"></script>
</body>
</html>
