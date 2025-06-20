<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="style/site.css">
</head>
<body>
	<h2>LOGIN</h2>

	<form action="login" method="post">
		<label>ID :</label> <input type="text" name="id"> <label>PASSWORD
			: </label> <input type="password" name="pw"><br> <input
			type="submit" value="ログイン">

	</form>

	<a href="user-add.jsp">新規会員登録</a><br>
	<a class="glass"
		href="${pageContext.request.contextPath}/views/Main/Top.jsp">Top画面</a>


</body>
</html>