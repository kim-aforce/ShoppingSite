/**
 * 管理者用画像アップロード機能
 * ドラッグ&ドロップ、ファイル選択、プレビュー機能を提供
 */

document.addEventListener('DOMContentLoaded', function() {
    const uploadArea = document.getElementById('uploadArea');
    const fileInput = document.getElementById('fileInput');
    const selectFileBtn = document.getElementById('selectFileBtn');
    const uploadProgress = document.getElementById('uploadProgress');
    const progressFill = document.getElementById('progressFill');
    const progressText = document.getElementById('progressText');
    const previewContainer = document.getElementById('previewContainer');
    const previewImage = document.getElementById('previewImage');
    const previewFileName = document.getElementById('previewFileName');
    const previewFileSize = document.getElementById('previewFileSize');
    const removeImageBtn = document.getElementById('removeImageBtn');
    const imageUrlField = document.getElementById('imageUrlField');
    const productForm = document.getElementById('productForm');
    const submitBtn = document.getElementById('submitBtn');

    let isUploading = false;
    let uploadedImageUrl = '';

    initialize();

    function initialize() {
        setupEventListeners();
        checkExistingImage();
    }

    function setupEventListeners() {
        selectFileBtn.addEventListener('click', () => {
            if (!isUploading) {
                fileInput.click();
            }
        });

        fileInput.addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                handleFileSelection(file);
            }
        });

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });

        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, highlight, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, unhighlight, false);
        });

        uploadArea.addEventListener('drop', handleDrop, false);

        removeImageBtn.addEventListener('click', removeImage);

        productForm.addEventListener('submit', handleFormSubmit);
    }

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    function highlight() {
        uploadArea.classList.add('drag-highlight');
    }

    function unhighlight() {
        uploadArea.classList.remove('drag-highlight');
    }

    function handleDrop(e) {
        const dt = e.dataTransfer;
        const files = dt.files;

        if (files.length > 0) {
            const file = files[0];
            handleFileSelection(file);
        }
    }

    function handleFileSelection(file) {
        if (!validateFile(file)) {
            return;
        }

        showPreview(file);
        uploadFile(file);
    }

    function validateFile(file) {
        const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
        if (!allowedTypes.includes(file.type)) {
            showAlert('サポートされていない画像形式です。JPG, PNG, GIF, WebP形式を使用してください。');
            return false;
        }

        const maxSize = 10 * 1024 * 1024;
        if (file.size > maxSize) {
            showAlert('ファイルサイズが大きすぎます。最大10MBまで対応しています。');
            return false;
        }

        return true;
    }

    function showPreview(file) {
        const reader = new FileReader();

        reader.onload = function(e) {
            previewImage.src = e.target.result;
            previewFileName.textContent = file.name;
            previewFileSize.textContent = formatFileSize(file.size);

            uploadArea.style.display = 'none';
            previewContainer.style.display = 'block';
        };

        reader.readAsDataURL(file);
    }

    function uploadFile(file) {
        isUploading = true;
        updateSubmitButton(false);
        showProgress();

        const formData = new FormData();
        formData.append('imageFile', file);

        fetch(getContextPath() + '/admin/upload-image', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            hideProgress();
            handleUploadResponse(data);
        })
        .catch(error => {
            hideProgress();
            console.error('アップロードエラー:', error);
            showAlert('アップロード中にネットワークエラーが発生しました。');
            removeImage();
        })
        .finally(() => {
            isUploading = false;
            updateSubmitButton(true);
        });
    }

    function handleUploadResponse(data) {
        if (data.status === 'success') {
            uploadedImageUrl = data.path;
            imageUrlField.value = data.path;
            showAlert('画像のアップロードが完了しました。', 'success');
            console.log('アップロード成功:', data);
        } else {
            showAlert('アップロードエラー: ' + data.message);
            removeImage();
        }
    }

    function showProgress() {
        uploadProgress.style.display = 'block';
        let progress = 0;
        const progressInterval = setInterval(() => {
            progress += 10;
            progressFill.style.width = progress + '%';
            if (progress >= 90) {
                clearInterval(progressInterval);
            }
        }, 100);
    }

    function hideProgress() {
        uploadProgress.style.display = 'none';
        progressFill.style.width = '0%';
    }

    function removeImage() {
        previewContainer.style.display = 'none';
        uploadArea.style.display = 'block';
        fileInput.value = '';
        imageUrlField.value = '';
        uploadedImageUrl = '';
        previewImage.src = '';
        previewFileName.textContent = '';
        previewFileSize.textContent = '';
    }

    function checkExistingImage() {
        if (imageUrlField.value && imageUrlField.value.trim() !== '') {
            uploadedImageUrl = imageUrlField.value;
        }
    }

    function handleFormSubmit(e) {
        if (isUploading) {
            e.preventDefault();
            showAlert('画像のアップロードが完了するまでお待ちください。');
            return false;
        }
        return true;
    }

    function updateSubmitButton(enabled) {
        submitBtn.disabled = !enabled;
        submitBtn.textContent = enabled ?
            (submitBtn.textContent.includes('登録') ? '登録' : '更新') :
            'アップロード中...';
    }

    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    function showAlert(message, type = 'error') {
        const alertClass = type === 'success' ? 'alert-success' : 'alert-error';

        const existingAlert = document.querySelector('.upload-alert');
        if (existingAlert) {
            existingAlert.remove();
        }

        const alertDiv = document.createElement('div');
        alertDiv.className = `upload-alert ${alertClass}`;
        alertDiv.textContent = message;

        document.body.appendChild(alertDiv);

        setTimeout(() => {
            if (alertDiv.parentNode) {
                alertDiv.remove();
            }
        }, 3000);
    }

    function getContextPath() {
        return window.location.pathname.substring(0, window.location.pathname.indexOf('/', 2));
    }
});
