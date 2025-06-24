<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jp.co.aforce.beans.userBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー登録確認ページ</title>
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container confirm-container">
        <div class="confirm-info">
            <p>ユーザーID：${user.memberId}</p>
            <p>パスワード：${user.password}</p>
            <p>名前（姓）：${user.lastname}</p>
            <p>名前（名）：${user.firstname}</p>
            <p>メールアドレス：${user.mailAddress}</p>
            <p>住所：${user.address}</p>
        </div>
        <div class="button-group">
            <form action="useradd-excute" method="post">
                <button type="submit" class="auth-btn btn-primary">登録</button>
            </form>
            <a href="user-add.jsp" class="auth-btn btn-secondary">登録画面に戻る</a>
        </div>
    </div>
</body>
</html>