<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編集ページ</title>
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container">
	<h2>会員情報編集</h2>
	
<!--name new complete	-->
	
<form class="auth-form" action="useredit-confirm" method="post">
    <div class="form-field">
        <label>名前（姓）</label>
        <input type="text" name="lastname" value="${user.lastname != null ? user.lastname : ''}" />
    </div>
    <div class="form-field">
        <label>名前（名）</label>
        <input type="text" name="firstname" value="${user.firstname != null ? user.firstname : ''}" />
    </div>
    <div class="form-field">
        <label>メールアドレス</label>
        <input type="email" name="mailAddress" value="${user.mailAddress != null ? user.mailAddress : ''}" />
    </div>
    <div class="form-field">
        <label>住所</label>
        <input type="text" name="address" value="${user.address != null ? user.address : ''}" />
    </div>
    <div class="button-group">
        <input type="submit" value="確認" class="auth-btn btn-primary" />
    </div>
</form>
<div class="button-group">
    <a href="user-menu.jsp" class="auth-btn btn-secondary">戻る</a>
</div>
    </div>
</body>
</html>