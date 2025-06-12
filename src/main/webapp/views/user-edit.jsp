<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編集ページ</title>
</head>
<body>
	<h2>会員情報編集</h2>
	
<!--name new complete	-->
	
<form action="useredit-confirm" method="post">
    名前（姓）：<input type="text" name="lastname" value="${user.lastname != null ? user.lastname : ''}" /><br>
    名前（名）：<input type="text" name="firstname" value="${user.firstname != null ? user.firstname : ''}" /><br>
    メールアドレス：<input type="email" name="mailAddress" value="${user.mailAddress != null ? user.mailAddress : ''}" /><br>
    住所：<input type="text" name="address" value="${user.address != null ? user.address : ''}" /><br>
    <input type="submit" value="確認" />
</form>

</body>
</html>