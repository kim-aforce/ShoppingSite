// adminUser.js

// モーダルを開く
function openModal(id) {
    document.getElementById(id).classList.add('active');
}

// モーダルを閉じる
function closeModal(id) {
    document.getElementById(id).classList.remove('active');
}

// イベントリスナー登録
document.querySelectorAll('.action-btn').forEach(btn => {
    const map = { 'btn-delete-user':'modal-delete-user', 'btn-change-type':'modal-change-type' };
    btn.addEventListener('click', () => openModal(map[btn.id]));
});

//クローズボタンバインド
document.querySelectorAll('.close').forEach(span => {
    span.addEventListener('click', () => closeModal(span.dataset.target));
});

//Delete, ChangeTypeセレクト初期化
window.addEventListener('DOMContentLoaded', () => {
    const deleteSel = document.getElementById('delete-user-select');
    const typeSel = document.getElementById('type-user-select');
    users.forEach(u => {
        let opt1 = new Option(u.name + ' ('+u.id+')', u.id);
        let opt2 = new Option(u.name + ' ('+u.id+')', u.id);
        deleteSel.add(opt1);
        typeSel.add(opt2);
    });
});