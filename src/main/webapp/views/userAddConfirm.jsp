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
<p>ユーザーID：</p>${user.memberId}<br>
<p>パスワード：</p>${user.password}<br>
<p>名前（姓）：</p>${user.lastname}<br>
<p>名前（名）：</p>${user.firstname}<br>
<p>メールアドレス：</p>${user.mailAddress}<br>
<p>住所：</p>${user.address}

<form action="useradd-excute" method = "post">
	<input type = "submit" value = "登録" >
</form>
<a href = "user-add.jsp">修正する</a>

</body>
</html>