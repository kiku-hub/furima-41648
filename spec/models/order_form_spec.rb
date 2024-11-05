require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user) # ユーザーを生成
    @item = FactoryBot.create(:item) # 商品を生成し、ユーザーIDを指定
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id) # ファクトリからインスタンスを生成
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
      it '郵便番号にハイフンを含まない場合、登録できない' do
        @order_form.postal_code = '1234567' # 良くない例
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:postal_code]).to include('must be in the format XXX-XXXX')
      end

      it '郵便番号が正しい形式であること' do
        @order_form.postal_code = '123-4567' # 良い例
        expect(@order_form).to be_valid
      end
    end

    context '電話番号のバリデーション' do
      it '9桁以下では登録できないこと' do
        @order_form.phone_number = '123456789' # 9桁
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it '12桁以上では登録できないこと' do
        @order_form.phone_number = '123456789012' # 12桁
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it '半角数字以外が含まれている場合、登録できないこと' do
        @order_form.phone_number = '090-1234-5678' # 半角数字以外が含まれている例
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')

        @order_form.phone_number = '０９０１２３４５６７８' # 全角数字
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it '10桁または11桁の場合は有効であること' do
        @order_form.phone_number = '09012345678' # 11桁
        expect(@order_form).to be_valid

        @order_form.phone_number = '0312345678' # 10桁
        expect(@order_form).to be_valid
      end
    end

    context '都道府県のバリデーション' do
      it 'region_idが1の場合は無効であること' do
        @order_form.region_id = 1
        expect(@order_form).to be_invalid
        expect(@order_form.errors[:region_id]).to include("can't be blank")
      end

      it 'region_idが1以外の場合は有効であること' do
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

      it '建物名が空でも保存に成功すること' do
        @order_form.building_name = nil # 建物名を空に設定
        expect(@order_form).to be_valid # 有効であることを期待
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
