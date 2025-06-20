<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="glass header2">
    <nav class="nav-links">
        <a href="<c:url value='/order/history'/>">注文履歴</a>
        <a href="<c:url value='/user/info'/>">会員情報</a>
        <a href="<c:url value='/logout'/>">ログアウト</a>
    </nav>
    <form action="<c:url value='/ProductList'/>" method="get" class="search-form">
        <input type="text" name="search" placeholder="検索">
        <button type="submit">検索</button>
    </form>
</header>
