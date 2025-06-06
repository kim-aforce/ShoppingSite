<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>会員登録情報が完了しました。</h2>
<a href="user-menu.jsp">メニューへ戻る</a>

<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String now = sdf.format(new java.util.Date());
%>
<p style="color:red;">エビデンス用リアルタイム<%= now %></p>
</body>
</html>