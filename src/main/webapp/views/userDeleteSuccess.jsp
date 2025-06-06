<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>削除完了</title>
</head>
<body>
<h2>削除完了</h2>

<a href="login-in.jsp">ログイン画面へ戻る</a>
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String now = sdf.format(new java.util.Date());
%>
<p style="color:red;">エビデンス用リアルタイム<%= now %></p>
</body>
</html>