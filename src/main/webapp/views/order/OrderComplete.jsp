<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文完了</title>
<link rel="stylesheet" href="../style/common.css">
<link rel="stylesheet" href="../style/site.css">
<link rel="stylesheet" href="../style/order.css">
</head>
<body>
    <jsp:include page="../common/header2.jsp" />
    
    <main class="order-complete-container">
        <div class="step-bar">Step1. Cart ▶ Step2. Order ▶ Step3. Order Confirmed</div>
        
        <div class="complete-message">
            <h2>注文を完了しました。</h2>
            <p>ご利用いただきありがとうございます。</p>
            <c:if test="${not empty param.orderId}">
                <p class="order-number">注文番号: ${param.orderId}</p>
            </c:if>
        </div>
        
        <div class="complete-actions">
            <a href="${pageContext.request.contextPath}/views/Main/Top.jsp" class="btn top-btn">TOPページへ</a>
            <a href="${pageContext.request.contextPath}/views/order/OrderHistory.jsp" class="btn history-btn">注文履歴</a>
        </div>
    </main>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>