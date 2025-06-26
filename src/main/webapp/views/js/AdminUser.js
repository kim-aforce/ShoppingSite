// adminUser.js - エラー対応修正版

// モーダルを開く
function openModal(id) {
    console.log('openModal 호출됨, id:', id); // デバッグ用
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.add('active');
        console.log('モーダル開いた:', id); // デバッグ用
    } else {
        console.error('モーダル要素が見つかりません:', id); // エラーログ
    }
}

// モーダルを閉じる
function closeModal(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.classList.remove('active');
    }
}

// DOM読み込み完了後に全てのイベントリスナーを登録
document.addEventListener('DOMContentLoaded', () => {
    console.log('AdminUser.js 読み込み完了'); // デバッグ用
    
    // 全てのモーダル要素が存在するかチェック
    const modalIds = ['modal-edit-user', 'modal-delete-user', 'modal-change-type'];
    modalIds.forEach(id => {
        const modal = document.getElementById(id);
        console.log(`モーダル ${id}:`, modal ? '存在' : '未発見');
    });
    
    // アクションボタンのイベントリスナー登録
    const actionButtons = document.querySelectorAll('.action-btn');
    console.log('action-btn 요素 개수:', actionButtons.length); // デバッグ用
    
    actionButtons.forEach(btn => {
        console.log('ボタンID:', btn.id); // デバッグ用
        
        const map = {
            'btn-edit-user': 'modal-edit-user', 
            'btn-delete-user': 'modal-delete-user', 
            'btn-change-type': 'modal-change-type' 
        };
        
        btn.addEventListener('click', () => {
            console.log('ボタンクリック:', btn.id); // デバッグ用
            const modalId = map[btn.id];
            if (modalId) {
                openModal(modalId);
            } else {
                console.error('매핑된 모달 ID를 찾을 수 없음:', btn.id);
            }
        });
    });

    // クローズボタンバインド
    document.querySelectorAll('.close').forEach(span => {
        span.addEventListener('click', () => {
            console.log('閉じるボタンクリック'); // デバッグ用
            closeModal(span.dataset.target);
        });
    });

    // モーダル外部クリック時に閉じる
    document.querySelectorAll('.modal').forEach(modal => {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal(modal.id);
            }
        });
    });

    // セレクト要素들 초기화
    const editSel = document.getElementById('edit-user-select');
    const deleteSel = document.getElementById('delete-user-select');
    const typeSel = document.getElementById('type-user-select');
    
    // users 배열 존재 체크
    if (typeof users === 'undefined') {
        console.error('users 배열이 정의되지 않음');
        return;
    }
    
    console.log('users 배열:', users); // デバッグ用
    
    if (users && users.length > 0) {
        users.forEach(u => {
            let editOpt = new Option(u.name + ' (' + u.id + ')', u.id);
            let deleteOpt = new Option(u.name + ' (' + u.id + ')', u.id);
            let typeOpt = new Option(u.name + ' (' + u.id + ')', u.id);
            
            if (editSel) editSel.add(editOpt);
            if (deleteSel) deleteSel.add(deleteOpt);
            if (typeSel) typeSel.add(typeOpt);
        });
    }

    // 編集セレクト変更イベント
    if (editSel) {
        editSel.addEventListener('change', () => {
            let u = users.find(x => x.id == editSel.value);
            if (!u) return;
            
            document.getElementById('edit-user-id').value = u.id;
            document.getElementById('edit-lastname').value = u.lastname;
            document.getElementById('edit-firstname').value = u.firstname;
            document.getElementById('edit-email').value = u.email;
            document.getElementById('edit-address').value = u.address || '';
            document.getElementById('edit-password').value = ''; // パスワードは空白
        });
    }
});