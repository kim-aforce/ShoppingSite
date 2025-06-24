<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修正確認ページ</title>
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container confirm-container">
        <h2>登録する内容はよろしいですか？</h2>

        <div class="confirm-info">

<p>名前（姓）：${editUser.lastname}</p>
<p>名前（名）：${editUser.firstname}</p>
<p>メールアドレス：${editUser.mailAddress}</p>
<p>住所：${editUser.address}</p>
        </div>

        <div class="button-group">
            <form action="useredit-execute" method="post">
    <input type="submit" value="登録" class="auth-btn btn-primary"/>
</form>

            <form action="useredit" method="post">
    <input type="submit" value="戻る" class="auth-btn btn-secondary"/>
</form>

    </div>
    </div>
</body>
</html>