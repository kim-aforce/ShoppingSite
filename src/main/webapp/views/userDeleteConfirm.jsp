<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>削除確認</title>
<link rel="stylesheet" href="style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/auth.css">

<script type="text/javascript">
function confirmDelete() {
    return confirm("削除してもよろしいですか？");
}
</script>
</head>
<body>
    <div class="auth-container confirm-container">
        <h2>会員削除</h2>

        <div class="confirm-info">
            <p>以下の情報を削除します。</p>
            <p>ユーザーID：${user.memberId}</p>
            <p>名前：${user.lastname} ${user.firstname}</p>
            <p>メールアドレス：${user.mailAddress}</p>
        </div>

        <div class="button-group">
            <form action="userdelete-execute" method="post" onsubmit="return confirmDelete()">
                <button type="submit" class="auth-btn btn-danger">削除</button>
            </form>

            <form action="user-menu.jsp" method="get">
                <button type="submit" class="auth-btn btn-secondary">キャンセル</button>
            </form>
        </div>
    </div>
</body>
</html>