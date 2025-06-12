<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
<h1>新規会員登録</h1>
<form action = "useradd" method = "post">

ユーザーID：<input type = "text" name = "memberId" required/>半角英数字<br>
パスワード：<input type = "password" name = "password" required/>半角英数字<br>
名前（姓）：<input type = "text" name = "lastname" required/><br>
名前（名）：<input type = "text" name = "firstname" required/><br>
メールアドレス：<input type = "email" name = "email" required/><br>
住所：<input type = "text" name = "address" />※任意<br>

<input type = "submit" value = "確認"/>
<input type = "reset" value = "リセット"/>
</form>


<br><br><a href = "login-in.jsp">戻る</a>
</body>
</html>