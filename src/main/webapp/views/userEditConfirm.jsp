<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修正確認ページ</title>
</head>
<body>
<h2>登録する内容はよろしいですか？</h2>

<p>名前（姓）：${editUser.lastname}</p>
<p>名前（名）：${editUser.firstname}</p>
<p>メールアドレス：${editUser.mailAddress}</p>
<p>住所：${editUser.address}</p>

<form action="useredit-execute" method="post">
    <input type="submit" value="登録"/>
</form>

<form action="useredit" method="post">
    <input type="submit" value="戻る"/>
</form>

</body>
</html>