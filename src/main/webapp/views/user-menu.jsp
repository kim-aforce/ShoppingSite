<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jp.co.aforce.beans.userBean"%>
<%@ page session="true" %>
<%
    Object obj = session.getAttribute("user");
    if (obj == null || !(obj instanceof UserBean)) {
        response.sendRedirect("login-in.jsp");
        return;
    }
    UserBean user = (UserBean) obj;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザーメニュー</title>
</head>
<body>

	<h2>ようこそ、<%= userBean.getFirstname() %>さん！</h2>
	
	<form action="#" method="post">
		<input type="submit" value="修正">
	</form>
	
	<form action="#" method="post">
		<input type="submit" value="削除">
	</form>
	
	<form action="#" method="post">
		<input type="submit" value="ログアウト">
	</form>

</body></html>