<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品管理フォーム</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/admin-upload.css">
    <style>
        /* インライン重要スタイル */
        .admin-form-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
        }
        
        .admin-form-container h2 {
            text-align: center;
            color: #d4af37;
            margin-bottom: 2rem;
        }
        
        /* 가로 레이아웃 */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
        }
        
        .basic-info {
            padding-right: 1rem;
        }
        
        .upload-section {
            padding-left: 1rem;
            border-left: 1px solid rgba(255,255,255,0.2);
        }
        
        .form-field {
            margin-bottom: 1.5rem;
        }
        
        .form-field label {
            display: block;
            color: #000000;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .form-field input,
        .form-field textarea,
        .form-field select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.9);
            color: #000000;
        }
        
        .upload-area {
            border: 2px dashed rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            padding: 2rem 1rem;
            text-align: center;
            background: rgba(255, 255, 255, 0.05);
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .upload-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        
        .upload-text {
            font-size: 1rem;
            color: #000000;
            margin: 0.5rem 0;
        }
        
        .upload-btn {
            background: linear-gradient(45deg, #d4af37, #b8941f);
            color: #000000;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .form-actions {
            grid-column: 1 / -1;
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .form-actions button,
        .btn-cancel {
            padding: 1rem 2rem;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .form-actions button {
            background: linear-gradient(45deg, #d4af37, #b8941f);
            color: #000000;
            border: none;
            cursor: pointer;
        }
        
        .btn-cancel {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #000000;
        }
        
        /* mobile */
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .upload-section {
                border-left: none;
                border-top: 1px solid rgba(255,255,255,0.2);
                padding-left: 0;
                padding-top: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <main class="admin-form-container">
        <h2>
            <c:choose>
                <c:when test="${mode == 'new'}">商品情報登録</c:when>
                <c:otherwise>商品情報修正</c:otherwise>
            </c:choose>
        </h2>

        <form action="${pageContext.request.contextPath}/admin/products/${mode}" method="post" id="productForm">
            <div class="form-grid">
                <!-- 基本情報 -->
                <div class="basic-info">
                    <c:if test="${mode == 'edit'}">
                        <input type="hidden" name="product_id" value="${product.product_id}"/>
                    </c:if>

                    <div class="form-field">
                        <label>商品名:</label>
                        <input type="text" name="product_name" value="${product.product_name}" required/>
                    </div>

                    <div class="form-field">
                        <label>説明:</label>
                        <textarea name="description" rows="3">${product.description}</textarea>
                    </div>

                    <div class="form-field">
                        <label>価格:</label>
                        <c:choose>
                            <c:when test="${product.price != null && product.price > 0}">
                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0" groupingUsed="false" var="priceInt" />
                                <input type="number" name="price" value="${priceInt}" required/>
                            </c:when>
                            <c:otherwise>
                                <input type="number" name="price" value="" required/>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="form-field">
                        <label>カテゴリ:</label>
                        <select name="category_id" required>
                            <option value="">カテゴリ選択</option>
                            <option value="01" <c:if test="${product.category_id=='01'}">selected</c:if>>衣類</option>
                            <option value="02" <c:if test="${product.category_id=='02'}">selected</c:if>>靴</option>
                            <option value="03" <c:if test="${product.category_id=='03'}">selected</c:if>>香水</option>
                            <option value="04" <c:if test="${product.category_id=='04'}">selected</c:if>>アクセサリー</option>
                            <option value="05" <c:if test="${product.category_id=='05'}">selected</c:if>>インテリア</option>
                        </select>
                    </div>

                    <div class="form-field">
                        <label>在庫数:</label>
                        <input type="number" name="stock_qty" value="${product.stock_qty}" min="0" required/>
                    </div>
                </div>

                <!-- 画像アップロード -->
                <div class="upload-section">
                    <label style = "color : #000000">商品画像:</label>
                    
                    <div class="upload-area" id="uploadArea">
                        <div class="upload-content">
                            <div class="upload-icon">📁</div>
                            <p class="upload-text">ドラッグ&ドロップ</p>
                            <button type="button" class="upload-btn" id="selectFileBtn">ファイル選択</button>
                            <p style="font-size: 0.8rem; color: rgba(255,255,255,0.7); margin-top: 0.5rem;">JPG, PNG, GIF (最大10MB)</p>
                        </div>
                    </div>
                    
                    <input type="file" id="fileInput" accept="image/*" style="display: none;">
                    
                    <div class="upload-progress" id="uploadProgress" style="display: none;">
                        <div class="progress-bar" style="width: 100%; height: 6px; background: rgba(255,255,255,0.2); border-radius: 3px; margin: 1rem 0;">
                            <div class="progress-fill" id="progressFill" style="height: 100%; background: #d4af37; border-radius: 3px; width: 0%; transition: width 0.3s;"></div>
                        </div>
                        <p class="progress-text" id="progressText" style="text-align: center; color: #d4af37; margin: 0;">アップロード中...</p>
                    </div>
                    
                    <div class="image-preview-container" id="previewContainer" style="display: none; margin-top: 1rem;">
                        <div class="image-preview" style="text-align: center; padding: 1rem; background: rgba(255,255,255,0.1); border-radius: 8px;">
                            <img id="previewImage" src="" alt="Preview" style="max-width: 200px; max-height: 200px; border-radius: 8px;">
                            <p id="previewFileName" style="color: #ffffff; margin: 0.5rem 0; font-size: 0.9rem;"></p>
                            <button type="button" class="remove-image-btn" id="removeImageBtn" style="background: #dc3545; color: white; border: none; padding: 0.5rem 1rem; border-radius: 15px; cursor: pointer;">削除</button>
                        </div>
                    </div>
                    
                    <c:if test="${mode == 'edit' && not empty product.image_url}">
                        <div style="margin-top: 1rem; text-align: center;">
                            <p style="color: rgba(255,255,255,0.8); margin-bottom: 0.5rem;">現在の画像:</p>
                            <img src="${product.image_url}" alt="Current" style="max-width: 150px; max-height: 150px; border-radius: 8px;">
                        </div>
                    </c:if>
                    
                    <input type="hidden" name="image_url" id="imageUrlField" value="${product.image_url}"/>
                </div>

                <!-- アクション -->
                <div class="form-actions">
                    <button type="submit" id="submitBtn">
                        <c:choose>
                            <c:when test="${mode == 'new'}">登録</c:when>
                            <c:otherwise>更新</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn-cancel">戻る</a>
                </div>
            </div>
        </form>
    </main>

    <jsp:include page="../common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/views/js/admin-upload.js"></script>
</body>
</html>