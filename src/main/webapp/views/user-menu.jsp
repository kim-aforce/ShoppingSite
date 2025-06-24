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
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container menu-container">
        <div class="welcome-message">
            <h2>
		ようこそ、<%= last_name %>さん！</h2>
        </div>
        <div class="menu-actions">
            <form action="../logout" method="post">
                <input type="submit" value="ログアウト" class="auth-btn btn-secondary">
            </form>

            <form action="useredit" method="post">
                <input type="submit" value="修正" class="auth-btn btn-primary">
            </form>

            <form action="userdelete-confirm" method="post">
                <input type="submit" value="削除" class="auth-btn btn-danger" />
            </form>
        </div>
<!--	<form action="../views/sessionCheck.jsp" method="get">-->
<!--		<input type = "submit" value = "セッション有効性検査">-->
<!--	</form>-->
    </div>
</body>
</html>