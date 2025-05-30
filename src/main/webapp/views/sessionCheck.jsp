<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jp.co.aforce.beans.userBean" %>
<%
    userBean user = (userBean) session.getAttribute("user");
    String sid = session.getId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session Check page</title>
</head>
<body>
<% if (user != null) { %>
	<h2 style = "color : blue">セッション有効状態</h2>
	<p>ユーザー：<%= user.getLastname() %>さん</p>
	<p>セッションID：<%= sid %></p>
	<a href = "user-menu.jsp">user-menuに戻る</a>
<% } else {%>
	<h2 style = "color : red">セッション無効状態</h2><br>
	<a href = "login-in.jsp">ログインページに戻る</a>
<% } %>


</body>
</html>