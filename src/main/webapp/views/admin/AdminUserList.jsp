<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会員管理</title>
    <!-- 管理者用CSS -->
    <script src="${pageContext.request.contextPath}/views/js/admin.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
</head>
<body>
    <!-- 共通ヘッダー読み込み -->
    <jsp:include page="../common/header2.jsp"/>

    <main class="admin-main">
        <!-- ページタイトル -->
        <h2 class="page-title">会員管理</h2>

        <div class="admin-actions">
            <button id="btn-delete-user" class="action-btn">会員削除</button>          <!-- 削除modal trigger -->
            <button id="btn-change-type" class="action-btn">権限変更</button>          <!-- 権限変更modal trigger -->
        </div>

        <!-- 会員削除モーダル -->
        <div id="modal-delete-user" class="modal">
            <div class="modal-content glass">
                <span class="close" data-target="modal-delete-user">&times;</span>
                <h3>会員削除</h3>
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="delete">
                    <label>会員選択 :
                        <select name="memberId" id="delete-user-select"></select>
                    </label>
                    <button type="submit" class="modal-btn" onclick="return confirm('削除してもよろしいですか？')">削除</button>
                </form>
            </div>
        </div>

        <!-- 権限変更モーダル -->
        <div id="modal-change-type" class="modal">
            <div class="modal-content glass">
                <span class="close" data-target="modal-change-type">&times;</span>
                <h3>権限変更</h3>
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="action" value="updateType">
                    <label>会員選択 :
                        <select name="memberId" id="type-user-select"></select>
                    </label>
                    <label>権限 :
                        <select name="userType">
                            <option value="USER">一般会員</option>
                            <option value="ADMIN">管理者</option>
                        </select>
                    </label>
                    <button type="submit" class="modal-btn">変更</button>
                </form>
            </div>
        </div>

        <!-- 会員一覧テーブル -->
        <div class="user-table-container glass" style="margin-top: 2rem; padding: 1rem;">
            <h3>会員一覧</h3>
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr style="background: rgba(255,255,255,0.1);">
                        <th style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">会員ID</th>
                        <th style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">氏名</th>
                        <th style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">メール</th>
                        <th style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">権限</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">${user.memberId}</td>
                            <td style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">${user.lastname} ${user.firstname}</td>
                            <td style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">${user.mailAddress}</td>
                            <td style="padding: 0.5rem; border: 1px solid rgba(255,255,255,0.3);">${user.userType}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script>
            // サーバから渡されたusersリストをJS配列に変換
            const users = [
                <c:forEach var="u" items="${users}" varStatus="sts">
                    { id:'${u.memberId}', 
                        name:'${u.lastname} ${u.firstname}', 
                        email:'${u.mailAddress}', 
                        type:'${u.userType}' }
                    <c:if test="${!sts.last}">,</c:if>
                </c:forEach>
            ];
        </script>
<script src="${pageContext.request.contextPath}/views/js/AdminUser.js"></script>
    </main>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>