<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header class="glass header-unified">
  <div class="header-container">
    <!-- ロゴ -->
    <h1 class="logo">
      <a href="${pageContext.request.contextPath}/views/Main/Top.jsp">
        <span class="logo-text">AlphaMale</span>
      </a>
    </h1>

    <!-- ナビゲーション -->
    <nav class="header-nav">
      <!-- 基本メニュー -->
      <a class="nav-link" href="${pageContext.request.contextPath}/views/product/ProductList">
        商品一覧
      </a>

      <!-- ログイン状態別メニュー -->
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <!-- ログイン時 -->
          <a class="nav-link" href="${pageContext.request.contextPath}/cart">
            カート
          </a>
          
          <!-- 管理者専用 -->
          <c:if test="${sessionScope.user.userType == 'ADMIN'}">
            <div class="dropdown">
              <span class="nav-link dropdown-toggle">管理</span>
              <div class="dropdown-menu">
                <a href="${pageContext.request.contextPath}/admin/products">商品管理</a>
                <a href="${pageContext.request.contextPath}/admin/users">会員管理</a>
              </div>
            </div>
          </c:if>
          
          <!-- ユーザーメニュー -->
          <div class="dropdown">
            <span class="nav-link dropdown-toggle">${sessionScope.user.lastname}様</span>
            <div class="dropdown-menu">
              <a href="${pageContext.request.contextPath}/views/order/OrderHistory">注文履歴</a>
              <a href="${pageContext.request.contextPath}/views/user-menu.jsp">会員情報</a>
              <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                <button type="submit" class="logout-btn">ログアウト</button>
              </form>
            </div>
          </div>
        </c:when>
        
        <c:otherwise>
          <!-- 非ログイン時 -->
          <div class="auth-section">
            <form action="${pageContext.request.contextPath}/views/login" method="post" class="login-form">
              <input type="text" name="id" placeholder="ID" class="login-input"/>
              <input type="password" name="pw" placeholder="PW" class="login-input"/>
              <button type="submit" class="btn-login">ログイン</button>
            </form>
            <a class="nav-link" href="${pageContext.request.contextPath}/views/user-add.jsp">
              会員登録
            </a>
          </div>
        </c:otherwise>
      </c:choose>
    </nav>
  </div>
</header>

<script>
document.addEventListener('DOMContentLoaded', () => {
    // AJAX ログイン処理
    const loginForm = document.querySelector('.login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(loginForm);
            formData.append('ajax', 'true');
            
            try {
                const response = await fetch(loginForm.action, {
                    method: 'POST',
                    body: new URLSearchParams(formData),
                    headers: { 'X-Requested-With': 'XMLHttpRequest' }
                });
                
                if (response.ok) {
                    const result = await response.json();
                    if (result.status === 'success') {
                        location.reload();
                    } else {
                        showAlert('ログインに失敗しました');
                    }
                }
            } catch (error) {
                showAlert('通信エラーが発生しました');
            }
        });
    }

    // AJAX ログアウト処理
    const logoutForms = document.querySelectorAll('.logout-form');
    logoutForms.forEach(form => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            try {
                const response = await fetch(form.action, {
                    method: 'POST',
                    body: new URLSearchParams({ajax: 'true'}),
                    headers: { 'X-Requested-With': 'XMLHttpRequest' }
                });
                
                if (response.ok) {
                    const result = await response.json();
                    if (result.status === 'success') {
                        location.reload();
                    }
                }
            } catch (error) {
                location.href = form.action;
            }
        });
    });

    // ドロップダウン制御
    const dropdowns = document.querySelectorAll('.dropdown');
    dropdowns.forEach(dropdown => {
        const toggle = dropdown.querySelector('.dropdown-toggle');
        const menu = dropdown.querySelector('.dropdown-menu');
        
        toggle.addEventListener('click', (e) => {
            e.stopPropagation();
            // 他のドロップダウンを閉じる
            dropdowns.forEach(other => {
                if (other !== dropdown) {
                    other.querySelector('.dropdown-menu').classList.remove('show');
                }
            });
            menu.classList.toggle('show');
        });
    });

    // 外部クリックでドロップダウン閉じる
    document.addEventListener('click', () => {
        dropdowns.forEach(dropdown => {
            dropdown.querySelector('.dropdown-menu').classList.remove('show');
        });
    });
});

function showAlert(message) {
    // カスタムアラート (必要に応じて実装)
    alert(message);
}
</script>