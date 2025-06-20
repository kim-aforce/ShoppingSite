// admin.js

//  モーダルを開く
function openModal(id) {
    document.getElementById(id).classList.add('active');
}

// モーダルを閉じる
function closeModal(id) {
    document.getElementById(id).classList.remove('active');
}

// イベントリスナー登録
document.querySelectorAll('.action-btn').forEach(btn => {
    const map = { 'btn-create':'modal-create', 'btn-edit':'modal-edit', 'btn-delete':'modal-delete' };
    btn.addEventListener('click', () => openModal(map[btn.id]));
});

//クローズボタンバインド
document.querySelectorAll('.close').forEach(span => {
    span.addEventListener('click', () => closeModal(span.dataset.target));
});

//Edit, Deleteセレクト初期化
window.addEventListener('DOMContentLoaded', () => {
    const editSel = document.getElementById('edit-select');
    const delSel  = document.getElementById('delete-select');
    products.forEach(p => {
        let opt1 = new Option(p.name + ' ('+p.id+')', p.id);
        let opt2 = new Option(p.name + ' ('+p.id+')', p.id);
        editSel.add(opt1);
        delSel.add(opt2);
    });
    // 編集選択時にフォームフィールドを埋める
    editSel.addEventListener('change', () => {
        let p = products.find(x => x.id == editSel.value);
        if (!p) return;
        document.getElementById('edit-id').value    = p.id;
        document.getElementById('edit-name').value  = p.name;
        document.getElementById('edit-desc').value  = p.desc;
        document.getElementById('edit-price').value = p.price;
        document.getElementById('edit-cat').value   = p.cat;
        document.getElementById('edit-stock').value = p.stock;
        document.getElementById('edit-img').value   = p.img;
    });
});
