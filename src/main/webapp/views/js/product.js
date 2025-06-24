/*

=========================================================
目的: ヘッダーの動的機能制御
機能: モーダル制御、AJAX認証、キーボードナビゲーション
=========================================================
*/

/**
 * ヘッダーコンポーネント初期化
 * DOMContentLoaded後に全機能を初期化
 */
document.addEventListener('DOMContentLoaded', function() {
    // DOM要素取得
    const elements = {
        loginToggle: document.querySelector('.login-toggle'),
        loginModal: document.getElementById('loginModal'),
        closeBtn: document.querySelector('.close-btn'),
        loginForm: document.querySelector('.login-form'),
        dropdownToggles: document.querySelectorAll('.admin-toggle, .user-toggle')
    };

    // 各機能を初期化
    initModalControls(elements);
    initAjaxLogin(elements);
    initKeyboardNavigation(elements);
});

/**
 * モーダル制御機能
 * @param {Object} elements - DOM要素オブジェクト
 */
function initModalControls(elements) {
    const { loginToggle, loginModal, closeBtn } = elements;

    // モーダル表示
    if (loginToggle && loginModal) {
        loginToggle.addEventListener('click', function() {
            loginModal.classList.add('active');
            focusFirstInput(loginModal);
        });
    }

    // 閉じるボタン
    if (closeBtn && loginModal) {
        closeBtn.addEventListener('click', function() {
            closeModal(loginModal);
        });
    }

    // 外側クリックで閉じる
    if (loginModal) {
        loginModal.addEventListener('click', function(e) {
            if (e.target === loginModal) {
                closeModal(loginModal);
            }
        });

        // ESCキーで閉じる
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && loginModal.classList.contains('active')) {
                closeModal(loginModal);
            }
        });
    }
}

/**
 * AJAX ログイン機能
 * @param {Object} elements - DOM要素オブジェクト
 */
function initAjaxLogin(elements) {
    const { loginForm } = elements;

    if (!loginForm) return;

    loginForm.addEventListener('submit', async function(e) {
        e.preventDefault();

        // フォームデータ準備
        const formData = new FormData(this);
        formData.append('ajax', 'true');

        try {
            // AJAX リクエスト送信
            const response = await fetch(this.action, {
                method: 'POST',
                body: new URLSearchParams(formData),
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            });

            // レスポンス処理
            if (response.ok) {
                const result = await response.json();
                handleLoginResponse(result);
            } else {
                showError('ネットワークエラーが発生しました。');
            }
        } catch (error) {
            console.error('Login error:', error);
            showError('ログイン処理中にエラーが発生しました。');
        }
    });
}

/**
 * キーボードナビゲーション強化
 * @param {Object} elements - DOM要素オブジェクト
 */
function initKeyboardNavigation(elements) {
    const { dropdownToggles } = elements;

    // ドロップダウンのキーボード制御
    dropdownToggles.forEach(toggle => {
        toggle.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                toggleDropdown(this);
            }
        });
    });
}

/**
 * モーダルを閉じる
 * @param {HTMLElement} modal - モーダル要素
 */
function closeModal(modal) {
    modal.classList.remove('active');
}

/**
 * 最初の入力フィールドにフォーカス
 * @param {HTMLElement} container - コンテナ要素
 */
function focusFirstInput(container) {
    const firstInput = container.querySelector('.form-input');
    if (firstInput) {
        firstInput.focus();
    }
}

/**
 * ログインレスポンス処理
 * @param {Object} result - サーバーレスポンス
 */
function handleLoginResponse(result) {
    if (result.status === 'success') {
        location.reload(); // 成功時はページリロード
    } else {
        showError('ログインに失敗しました。IDとパスワードを確認してください。');
    }
}

/**
 * エラーメッセージ表示
 * @param {string} message - エラーメッセージ
 */
function showError(message) {
    alert(message); // 実際のプロジェクトではトースト通知等に変更
}

/**
 * ドロップダウン表示切り替え
 * @param {HTMLElement} toggle - トグルボタン
 */
function toggleDropdown(toggle) {
    const dropdown = toggle.parentNode.querySelector('.admin-dropdown, .user-dropdown');
    if (dropdown) {
        const isVisible = dropdown.style.opacity === '1';
        dropdown.style.opacity = isVisible ? '0' : '1';
        dropdown.style.visibility = isVisible ? 'hidden' : 'visible';
        dropdown.style.transform = isVisible ? 'translateY(-10px)' : 'translateY(0)';
    }
}