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

	<form action="../logout" method="post">
		<input type="submit" value="ログアウト">
	</form>
	
<form action="useredit" method="post">
    <input type="submit" value="修正">
</form>
	
<form action="userdelete-confirm" method="post">
    <input type="submit" value="削除" />
</form>	
<!--	<form action="../views/sessionCheck.jsp" method="get">-->
<!--		<input type = "submit" value = "セッション有効性検査">-->
<!--	</form>-->
</body>
</html>