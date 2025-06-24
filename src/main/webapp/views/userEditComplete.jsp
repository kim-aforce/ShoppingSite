<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">
</head>
<body>
    <div class="auth-container success-container">
        <div class="success-message">
            <h2>会員登録情報が完了しました。</h2>
        </div>
        <a href="user-menu.jsp" class="auth-link">メニューへ戻る</a>
        <br>
        <a href="${pageContext.request.contextPath}/views/Main/Top.jsp" class="auth-link">Top画面へ</a>
    </div>
</body>
</html>