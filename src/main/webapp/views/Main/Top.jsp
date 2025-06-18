<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>ECサイト</title>
<link rel="stylesheet" href="../style/style.css">
<!-- 必要に応じてCSS適用 -->
</head>
<body>
	<!-- ヘッダー　-->
	<header>
		<h1><p style="color:#f5f2d0">Boy To Man</p></h1> <!--  font color : off white -->
		<nav>
			<a href="../login-in.jsp">Login</a> <a href="../user-add.jsp">会員登録</a>
		</nav>
	</header>

	<!-- メインバナー -->
	<section id="main-banner">
		<h2 style = "color:f5f2d0">男の第一歩</h2>
		<button onclick="location.href='ProductList'">Shop Now</button>
		<img src="../img/main-banner.jpg" alt="background" class="banner-img">

	</section>


	<!-- フッター  -->
	<footer>
		<p>&copy; 2025 新人研修</p>
	</footer>
</body>
</html>
