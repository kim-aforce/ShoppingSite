// =================================================
// 住所フォーム制御 - zipcloud API連携
// =================================================

class AddressForm {
    constructor() {
        this.API_URL = 'https://zipcloud.ibsnet.co.jp/api/search';
        this.fields = {
            zipcode: 'zipcode',
            prefecture: 'prefecture', 
            city: 'city',
            town: 'town',
            detail: 'detail'
        };
    }

    // API呼び出し
    async fetchAddress(zipcode) {
        try {
            const response = await fetch(`${this.API_URL}?zipcode=${zipcode}`);
            const data = await response.json();
            return data.results?.[0] || null;
        } catch (error) {
            console.error('住所取得エラー:', error);
            return null;
        }
    }

    // 郵便番号正規化
    normalizeZipcode(input) {
        return input.replace(/\D/g, '');
    }

    // 住所フィールド更新
    updateAddressFields(addressData) {
        const elements = this.getElements();
        if (!elements.prefecture || !addressData) return;

        elements.prefecture.value = addressData.address1 || '';
        elements.city.value = addressData.address2 || '';
        elements.town.value = addressData.address3 || '';

        // 詳細住所が空の場合のみ基本住所設定
        if (!elements.detail.value.trim()) {
            const fullAddress = [
                addressData.address1,
                addressData.address2, 
                addressData.address3
            ].filter(Boolean).join('');
            elements.detail.value = fullAddress;
        }
    }

    // DOM要素取得
    getElements() {
        return {
            zipcode: document.getElementById(this.fields.zipcode),
            prefecture: document.getElementById(this.fields.prefecture),
            city: document.getElementById(this.fields.city),
            town: document.getElementById(this.fields.town),
            detail: document.getElementById(this.fields.detail)
        };
    }

    // 郵便番号入力イベント処理
    async handleZipcodeInput(event) {
        const zipcode = this.normalizeZipcode(event.target.value);
        
        if (zipcode.length !== 7) return;

        const addressData = await this.fetchAddress(zipcode);
        this.updateAddressFields(addressData);
    }

    // 初期化
    init() {
        const elements = this.getElements();
        
        if (!elements.zipcode) {
            console.warn('郵便番号フィールドが見つかりません');
            return;
        }

        // blurイベントバインド
        elements.zipcode.addEventListener('blur', (e) => {
            this.handleZipcodeInput(e);
        });

        // 入力制限（数字のみ）
        elements.zipcode.addEventListener('input', (e) => {
            e.target.value = this.normalizeZipcode(e.target.value);
        });
    }
}

// 自動初期化
document.addEventListener('DOMContentLoaded', () => {
    const addressForm = new AddressForm();
    addressForm.init();
});

// グローバル関数（後方互換性）
window.AddressForm = AddressForm;ㄴ