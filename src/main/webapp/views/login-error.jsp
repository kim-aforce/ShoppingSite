<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラー</title>
</head>
<div class="error-container">
    <h3>エラーが発生しました</h3>
    
    <%
        // エラーメッセージとリターンURL取得
        String errorMessage = (String) request.getAttribute("errorMessage");
        String returnUrl = (String) request.getAttribute("returnUrl");
        
        // デフォルト値設定（既存ログインエラー用）
        if (errorMessage == null) {
            errorMessage = "ID又はパスワードを再度確認してください。";
        }
        if (returnUrl == null) {
            returnUrl = "login-in.jsp";
        }
    %>
    
    <!-- エラーメッセージ表示 -->
    <div class="error-message">
        <%= errorMessage %>
    </div>
    
    <!-- 戻るボタン -->
    <form action="<%= returnUrl %>" method="get">
        <input type="submit" value="戻る" class="back-button">
    </form>
</div>
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    String now = sdf.format(new java.util.Date());
%>
<p style="color:red;">エビデンス用リアルタイム<%= now %></p>
</body>
</html>