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
    const map = {
		'btn-eidt-user' : 'modal-edit-user', 
		'btn-delete-user':'modal-delete-user', 
		'btn-change-type':'modal-change-type' 
	};
    btn.addEventListener('click', () => openModal(map[btn.id]));
});

//クローズボタンバインド
document.querySelectorAll('.close').forEach(span => {
    span.addEventListener('click', () => closeModal(span.dataset.target));
});

//Delete, ChangeTypeセレクト初期化
window.addEventListener('DOMContentLoaded', () => {
    const editSel = document.getElementById('edit-user-select');
    const deleteSel = document.getElementById('delete-user-select');
    const typeSel = document.getElementById('type-user-select');
    
    users.forEach(u => {
        let editOpt = new Option(u.name + ' ('+u.id+')', u.id);
        let deleteOpt = new Option(u.name + ' ('+u.id+')', u.id);
        let typeOpt = new Option(u.name + ' ('+u.id+')', u.id);
        
        if(editSel) editSel.add(editOpt);
        if(deleteSel) deleteSel.add(deleteOpt);
        if(typeSel) typeSel.add(typeOpt);
    });
	
	if(editSel) {
	        editSel.addEventListener('change', () => {
	            let u = users.find(x => x.id == editSel.value);
	            if (!u) return;
	            document.getElementById('edit-user-id').value = u.id;
	            document.getElementById('edit-lastname').value = u.lastname;
	            document.getElementById('edit-firstname').value = u.firstname;
	            document.getElementById('edit-email').value = u.email;
	            document.getElementById('edit-address').value = u.address || '';
	            document.getElementById('edit-password').value = ''; // passwordは空白
	        });
	    }
	});