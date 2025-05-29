<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jp.co.aforce.beans.userBean"%>
<%@ page session="true"%>

<%
userBean user = (userBean) session.getAttribute("user");
String last_name = (user != null ) ? user.getLastname() : "Guest";	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員情報登録ホーム</title>
</head>
<body>

	<h2>
		ようこそ、<%= last_name %>さん！
	</h2>

	<form>
		<input type="button" value="修正">
		 <input type="button"value="削除">
		 <input type="button" value="ログアウト">
	</form>

</body>
</html>