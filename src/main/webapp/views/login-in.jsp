<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container login-container">
        <h2 class="login-header">LOGIN</h2>

        <form action="login" method="post" class="auth-form">
            <div class="form-field">
                <label>ID :</label>
                <input type="text" name="id">
            </div>
            <div class="form-field">
                <label>PASSWORD :</label>
                <input type="password" name="pw">
            </div>
            <div class="button-group">
                <input type="submit" value="ログイン" class="auth-btn btn-primary">
            </div>
        </form>

        <div class="login-footer">
            <a href="user-add.jsp" class="auth-link">新規会員登録</a><br>
            <a class="auth-link" href="${pageContext.request.contextPath}/views/Main/Top.jsp">Top画面</a>
        </div>
    </div>

</body>
</html>