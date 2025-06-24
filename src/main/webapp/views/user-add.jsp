<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規会員登録</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container">
        <h1>新規会員登録</h1>
        
        <form action="useradd" method="post" class="auth-form">
            <div class="form-field">
                <label class="required">ユーザーID</label>
                <input type="text" name="memberId" required placeholder="半角英数字">
            </div>
            
            <div class="form-field">
                <label class="required">パスワード</label>
                <input type="password" name="password" required placeholder="半角英数字">
            </div>
            
            <div class="form-field">
                <label class="required">名前（姓）</label>
                <input type="text" name="lastname" required>
            </div>
            
            <div class="form-field">
                <label class="required">名前（名）</label>
                <input type="text" name="firstname" required>
            </div>
            
            <div class="form-field">
                <label class="required">メールアドレス</label>
                <input type="email" name="email" required>
            </div>
            
            <div class="form-field">
                <label>住所（任意）</label>
                <input type="text" name="address">
            </div>
            
            <div class="button-group">
                <button type="submit" class="auth-btn btn-primary">確認</button>
                <button type="reset" class="auth-btn btn-secondary">リセット</button>
            </div>
        </form>
        
        <div style="text-align: center; margin-top: 2rem; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.2);">
            <a href="login-in.jsp" class="auth-link">戻る</a>
            <span style="margin: 0 1rem; color: rgba(255,255,255,0.5);">|</span>
            <a href="${pageContext.request.contextPath}/views/Main/Top.jsp" class="auth-link">Top画面</a>
        </div>
    </div>
</body>
</html>