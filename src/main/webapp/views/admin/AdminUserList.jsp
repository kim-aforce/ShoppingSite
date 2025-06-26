<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会員管理</title>
    <!-- 管理者用CSS -->
    
   <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/site.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/common.css">
    
</head>
<body>
    <!-- 共通ヘッダー読み込み -->
    <jsp:include page="../common/header.jsp"/>

    <main class="admin-main">
        <!-- ページタイトル -->
        <h2 style="color: #d4af37;" class="page-title">会員管理</h2>

        <div class="admin-actions">
            <button id="btn-edit-user" class="action-btn">会員修正</button>          <!-- 編集modal trigger  -->
            <button id="btn-delete-user" class="action-btn">会員削除</button>          <!-- 削除modal trigger -->
            <button id="btn-change-type" class="action-btn">権限変更</button>          <!-- 権限変更modal trigger -->
        </div>
        <!-- 会員情報変更モーダル-->
		<div id="modal-edit-user" class="modal">
			<div class="modal-content glass">
				<span class="close" data-target="modal-edit-user">&times;</span>
				<h3>会員情報修正</h3>
				<label>会員選択 : <select id="edit-user-select"></select>
				</label>
				<form id="form-edit-user"
					action="${pageContext.request.contextPath}/admin/users"
					method="post">
					<input type="hidden" name="action" value="update"> <input
						type="hidden" name="memberId" id="edit-user-id"> <label>名前（姓）
						:<input name="lastname" id="edit-lastname" required>
					</label> <label>名前（名） :<input name="firstname" id="edit-firstname"
						required></label> <label>メールアドレス :<input
						name="mailAddress" id="edit-email" type="email" required></label>
					<label>住所 :<input name="address" id="edit-address"></label>
					<label>パスワード :<input name="password" id="edit-password"
						type="password" placeholder="変更しない場合は空白"></label>

					<button type="submit" class="modal-btn">更新</button>
				</form>
			</div>
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
                { 
                    id:'${u.memberId}', 
                    lastname:'${u.lastname}',
                    firstname:'${u.firstname}',
                    name:'${u.lastname} ${u.firstname}', 
                    email:'${u.mailAddress}', 
                    address:'${u.address}',
                    type:'${u.userType}' 
                }
                <c:if test="${!sts.last}">,</c:if>
            </c:forEach>
            ];
        </script>
    </main>

<jsp:include page="../common/footer.jsp"/>
<script>
document.addEventListener('DOMContentLoaded', () => {
    console.log('モーダル初期化開始');
    
    // モーダル制御関数
    function openModal(id) {
        const modal = document.getElementById(id);
        if (modal) {
            modal.classList.add('active');
        } else {
            console.error('モーダル要素未発見:', id);
        }
    }
    
    function closeModal(id) {
        const modal = document.getElementById(id);
        if (modal) {
            modal.classList.remove('active');
        }
    }
    
    // ボタンイベント登録
    const btnEdit = document.getElementById('btn-edit-user');
    const btnDelete = document.getElementById('btn-delete-user');
    const btnType = document.getElementById('btn-change-type');
    
    if (btnEdit) btnEdit.addEventListener('click', () => openModal('modal-edit-user'));
    if (btnDelete) btnDelete.addEventListener('click', () => openModal('modal-delete-user'));
    if (btnType) btnType.addEventListener('click', () => openModal('modal-change-type'));
    
    // 閉じるボタン
    document.querySelectorAll('.close').forEach(span => {
        span.addEventListener('click', () => closeModal(span.dataset.target));
    });
    
    // セレクト初期化
    if (typeof users !== 'undefined') {
        const editSel = document.getElementById('edit-user-select');
        const deleteSel = document.getElementById('delete-user-select');
        const typeSel = document.getElementById('type-user-select');
        
        users.forEach(u => {
            const optText = u.name + ' (' + u.id + ')';
            if (editSel) editSel.add(new Option(optText, u.id));
            if (deleteSel) deleteSel.add(new Option(optText, u.id));
            if (typeSel) typeSel.add(new Option(optText, u.id));
        });
        
        // 編集セレクト変更
        if (editSel) {
            editSel.addEventListener('change', () => {
                const u = users.find(x => x.id == editSel.value);
                if (u) {
                    document.getElementById('edit-user-id').value = u.id;
                    document.getElementById('edit-lastname').value = u.lastname;
                    document.getElementById('edit-firstname').value = u.firstname;
                    document.getElementById('edit-email').value = u.email;
                    document.getElementById('edit-address').value = u.address || '';
                    document.getElementById('edit-password').value = '';
                }
            });
        }
    }
});
</script>
</body>
</html>