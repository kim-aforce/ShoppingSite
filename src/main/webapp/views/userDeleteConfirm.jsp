<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>削除確認</title>

<script type="text/javascript">
function confirmDelete() {
    return confirm("削除してもよろしいですか？");
}
</script>
</head>
<body>
<h2>会員削除</h2>

<p>以下の情報を削除します。</p>
<p>ユーザーID：${user.memberId}</p>
<p>名前：${user.lastname} ${user.firstname}</p>
<p>メールアドレス：${user.mailAddress}</p>

<form action="userdelete-execute" method = "post" onsubmit="return confirmDelete()">
	<input type ="submit" value = "削除"/>
</form>

<form action="user-menu.jsp" method="get">
    <input type="submit" value="キャンセル"/>
</form>
</body>
</html>