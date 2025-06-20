<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="glass header2">
  <div class="header-inner">
    <h1 class="logo">
      <a style="color: #FAF9F6;"
         href="${pageContext.request.contextPath}/views/Main/Top.jsp">
        AlphaMale
      </a>
    </h1>
    <nav class="header-nav">
      <a class="glass"
         href="${pageContext.request.contextPath}/views/product/ProductList.jsp">
        商品一覧
      </a>

      <c:if test="${not empty sessionScope.user and sessionScope.user.userType == 'ADMIN'}">
        <a class="glass"
           href="${pageContext.request.contextPath}/admin/products">
          商品管理
        </a>
      </c:if>

      <%-- 로그인 상태에 따른 분기 --%>
      <c:choose>
        <%-- 로그인된 경우 --%>
        <c:when test="${not empty sessionScope.user}">
          <a class="glass"
             href="${pageContext.request.contextPath}/views/order/OrderHistory.jsp">
            注文履歴
          </a>
          <a class="glass"
             href="${pageContext.request.contextPath}/views/user-menu.jsp">
            会員情報
          </a>
          <form action="${pageContext.request.contextPath}/logout"
                method="post" style="display:inline;">
            <button type="submit" class="glass logout-btn">
              ログアウト
            </button>
          </form>
        </c:when>
        <%-- 미로그인된 경우 --%>
        <c:otherwise>
          <form action="${pageContext.request.contextPath}/views/login"
                method="post"
                class="login-form">
            <input type="text" name="id" placeholder="ID"/>
            <input type="password" name="pw" placeholder="PW"/>
            <button type="submit" class="glass">
              ログイン
            </button>
          </form>
          <a class="glass"
             href="${pageContext.request.contextPath}/views/user-add.jsp">
            会員登録
          </a>
        </c:otherwise>
      </c:choose>
    </nav>
  </div>
</header>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.login-form');
    if (form) {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(form);
            formData.append('ajax', 'true');
            const params = new URLSearchParams(formData);
            const res = await fetch(form.action, {
                method: 'POST',
                body: params,
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            });
            if (res.ok) {
                const result = await res.json();
                if (result.status === 'success') {
                    location.reload();
                } else {
                    alert('ログインに失敗しました');
                }
            }
        });
    }
});
</script>