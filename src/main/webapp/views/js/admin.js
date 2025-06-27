// admin.js - 商品管理JavaScript（修正版）

/**
 * モーダルを開く関数
 * @param {string} id - モーダル要素のID
 */
function openModal(id) {
    document.getElementById(id).classList.add('active');
}

/**
 * モーダルを閉じる関数
 * @param {string} id - モーダル要素のID
 */
function closeModal(id) {
    document.getElementById(id).classList.remove('active');
}

// 🔧 修正: 商品登録ボタンを除外（新規ページ遷移のため不要）
// イベントリスナー登録 - 修正・削除ボタンのみ
document.querySelectorAll('.action-btn').forEach(btn => {
    const map = { 
        // 'btn-create':'modal-create', // 🗑️ 削除: 登録ボタンイベント除外
        'btn-edit':'modal-edit',         // 修正モーダル
        'btn-delete':'modal-delete'      // 削除モーダル
    };
    
    btn.addEventListener('click', () => {
        if (map[btn.id]) {
            openModal(map[btn.id]);
        }
    });
});

// 閉じるボタンバインド
document.querySelectorAll('.close').forEach(span => {
    span.addEventListener('click', () => closeModal(span.dataset.target));
});

// モーダル外クリックで閉じる
document.querySelectorAll('.modal').forEach(modal => {
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            closeModal(modal.id);
        }
    });
});

// 🔧 修正: 編集・削除セレクト初期化（登録関連コード除外）
window.addEventListener('DOMContentLoaded', () => {
    const editSel = document.getElementById('edit-select');   // 修正用セレクト
    const delSel  = document.getElementById('delete-select'); // 削除用セレクト
    
    // 商品データが存在するかチェック
    if (typeof products === 'undefined' || products.length === 0) {
        console.warn('商品データが見つかりません');
        return;
    }
    
    // セレクトオプション生成
    products.forEach(p => {
        let opt1 = new Option(p.name + ' (ID:' + p.id + ')', p.id); // 修正用オプション
        let opt2 = new Option(p.name + ' (ID:' + p.id + ')', p.id); // 削除用オプション
        
        if (editSel) editSel.add(opt1);
        if (delSel) delSel.add(opt2);
    });
    
    // 🔧 修正: 編集選択時のフォームフィールド自動入力
    if (editSel) {
        editSel.addEventListener('change', () => {
            const selectedProduct = products.find(x => x.id == editSel.value);
            if (!selectedProduct) return;
            
            // フォームフィールドに選択された商品情報を自動入力
            document.getElementById('edit-id').value    = selectedProduct.id;       // 商品ID
            document.getElementById('edit-name').value  = selectedProduct.name;     // 商品名
            document.getElementById('edit-desc').value  = selectedProduct.desc;     // 説明
            document.getElementById('edit-price').value = selectedProduct.price;    // 価格
            document.getElementById('edit-cat').value   = selectedProduct.cat;      // カテゴリ
            document.getElementById('edit-stock').value = selectedProduct.stock;    // 在庫数
            document.getElementById('edit-img').value   = selectedProduct.img;      // 画像URL（従来通り）
        });
    }
});

/**
 * 🆕 新機能: 成功メッセージ表示
 * @param {string} message - 表示メッセージ
 * @param {string} type - メッセージタイプ（success, error, warning）
 */
function showMessage(message, type = 'success') {
    // 既存メッセージがあれば削除
    const existingMessage = document.querySelector('.admin-message');
    if (existingMessage) {
        existingMessage.remove();
    }
    
    // 新しいメッセージ要素作成
    const messageDiv = document.createElement('div');
    messageDiv.className = `admin-message ${type}`;
    messageDiv.textContent = message;
    messageDiv.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 1rem 1.5rem;
        border-radius: 8px;
        color: white;
        font-weight: bold;
        z-index: 10000;
        animation: slideInRight 0.3s ease;
    `;
    
    // タイプ別スタイル適用
    switch(type) {
        case 'success':
            messageDiv.style.background = 'rgba(76, 175, 80, 0.9)';
            break;
        case 'error':
            messageDiv.style.background = 'rgba(220, 53, 69, 0.9)';
            break;
        case 'warning':
            messageDiv.style.background = 'rgba(255, 193, 7, 0.9)';
            break;
    }
    
    document.body.appendChild(messageDiv);
    
    // 3秒後自動削除
    setTimeout(() => {
        if (messageDiv.parentNode) {
            messageDiv.remove();
        }
    }, 3000);
}

/**
 * 🆕 新機能: URLパラメータから操作結果確認
 * 新規登録・修正・削除後のリダイレクト時にメッセージ表示
 */
function checkOperationResult() {
    const urlParams = new URLSearchParams(window.location.search);
    const result = urlParams.get('result');
    
    switch(result) {
        case 'created':
            showMessage('商品が正常に登録されました', 'success');
            break;
        case 'updated':
            showMessage('商品情報が正常に更新されました', 'success');
            break;
        case 'deleted':
            showMessage('商品が正常に削除されました', 'success');
            break;
        case 'error':
            showMessage('操作中にエラーが発生しました', 'error');
            break;
    }
    
    // URLパラメータをクリーン（ブラウザ履歴から除去）
    if (result) {
        const newUrl = window.location.pathname;
        window.history.replaceState({}, document.title, newUrl);
    }
}

// ページ読み込み完了時に操作結果確認
document.addEventListener('DOMContentLoaded', checkOperationResult);