require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = OrderForm.new(
      user_id: 1,
      item_id: 1,
      postal_code: '123-4567',
      region_id: 2,
      city: '東京都',
      house_number: '1-1-1',
      building_name: '青山マンション',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000' # テスト用のトークン
    )
  end

  describe 'バリデーション' do
    context '必須項目のバリデーション' do
      it '全ての項目が入力されていれば購入ができる' do
        expect(@order_form).to be_valid
      end

      it 'token(クレジットカード情報)が空だと購入ができない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空の場合は無効であること' do
        @order_form.user_id = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空の場合は無効であること' do
        @order_form.item_id = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:item_id]).to include("can't be blank")
      end

      it 'postal_codeが空の場合は無効であること' do
        @order_form.postal_code = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:postal_code]).to include("can't be blank")
      end

      it 'region_idが空の場合は無効であること' do
        @order_form.region_id = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:region_id]).to include("can't be blank")
      end

      it 'cityが空の場合は無効であること' do
        @order_form.city = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:city]).to include("can't be blank")
      end

      it 'house_numberが空の場合は無効であること' do
        @order_form.house_number = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:house_number]).to include("can't be blank")
      end

      it 'phone_numberが空の場合は無効であること' do
        @order_form.phone_number = nil
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include("can't be blank")
      end
    end

    context '郵便番号のバリデーション' do
      it '郵便番号が正しい形式であること' do
        @order_form.postal_code = '1234567' # 良くない例
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:postal_code]).to include('must be in the format XXX-XXXX')

        @order_form.postal_code = '123-4567' # 良い例
        expect(@order_form).to be_valid
      end
    end

    context '電話番号のバリデーション' do
      it '電話番号が10桁または11桁であること' do
        @order_form.phone_number = '090-1234-5678' # 良くない例
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')

        @order_form.phone_number = '09012345678' # 良い例
        expect(@order_form).to be_valid

        @order_form.phone_number = '123456789012' # 良くない例
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end
    end

    context '都道府県のバリデーション' do
      it 'region_idは1以外であること' do
        @order_form.region_id = 1
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:region_id]).to include("can't be blank")

        @order_form.region_id = 2
        expect(@order_form).to be_valid
      end
    end
  end

  describe '保存処理' do
    context '保存が成功する場合' do
      it '有効な値が全て設定されている場合、保存に成功すること' do
        expect(@order_form).to be_valid
      end
    end

    context '保存が失敗する場合' do
      it '無効な値が含まれている場合、保存に失敗すること' do
        @order_form.postal_code = '1234567' # 郵便番号が無効
        expect(@order_form.save).to be_falsey
        expect(@order_form.errors[:postal_code]).to include('must be in the format XXX-XXXX')
      end
    end
  end
end
