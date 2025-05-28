<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
</head>
<body>
<h2>LOGIN</h2>

<form action="<%= request.getContextPath() %>/login" method="post">
ID : <input type = "text" name = "id" >
PASSWORD : <input type = "password" name = "password" ><br>
<input type = "submit" value = "ログイン">
</form>

<!--register.jspは今後作る予定-->
<form action="register.jsp" method="get">
	<input type="submit" value="新規会員登録">
</form>


</body>
</html>