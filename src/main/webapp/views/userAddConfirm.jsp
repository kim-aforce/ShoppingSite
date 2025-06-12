<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jp.co.aforce.beans.userBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー登録確認ページ</title>
</head>
<body>
<p>ユーザーID：</p>${user.memberId}
<p>パスワード：</p>${user.password}
<p>名前（姓）：</p>${user.lastname}
<p>名前（名）：</p>${user.firstname}
<p>メールアドレス：</p>${user.mailAddress}
<p>住所：</p>${user.address}

<form action="useradd-excute" method = "post">
	<input type = "submit" value = "登録" >
</form>
<a href = "user-add.jsp">登録画面に戻る</a>
</body>
</html>