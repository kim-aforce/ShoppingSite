<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>ECサイト</title>
<link rel="stylesheet" href="../style/Top.css">
<link rel="stylesheet" href="../style/common.css">
<style>
@font-face {
    font-family: 'TsukuhouShogoMin';
    src: url('../style/TsukuhouShogoMin-OFL.otf') format('opentype');
}
body {
    font-family: 'TsukuhouShogoMin', serif;
}
</style>
<!-- 必要に応じてCSS適用 -->
</head>
<body>
	<!-- ヘッダー　-->
	<jsp:include page="../common/header.jsp" />

	<!-- メインバナー -->
	<section id="main-banner">
		<h2 style="color: #d4af37;">男になりたいあなたの為に</h2>
		<!-- 商品一覧へ遷移 -->
		<button class="glass"
			onclick="location.href='../product/ProductList'">Shop Now</button>
               <img src="../img/godfather.jpg" alt="background" class="banner-img">
	</section>


	<!-- フッター  -->
       <jsp:include page="../common/footer.jsp" />
       <script src="../js/randomBanner.js"></script>

</body>
</html>
