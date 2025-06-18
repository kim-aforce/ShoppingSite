<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>ECサイト</title>
<link rel="stylesheet" href="../style/Top.css">
<link rel="stylesheet" href="../style/common.css">
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap"
	rel="stylesheet">

<!-- 必要に応じてCSS適用 -->
</head>
<body>
	<!-- ヘッダー　-->
	<jsp:include page="../common/header.jsp" />

	<!-- メインバナー -->
	<section id="main-banner">
		<h2 style="color: #212121">男になりたいあなたの為に</h2>
		<button class="glass" onclick="location.href='ProductList'">Shop
			Now</button>
		<img src="../img/main-banner2.png" alt="background" class="banner-img">

	</section>


	<!-- フッター  -->
	<jsp:include page="../common/footer.jsp" />

</body>
</html>
