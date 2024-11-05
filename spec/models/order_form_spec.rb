require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入ができる時' do
      it '全ての情報が正しく入力されているとき' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_form.building_name = nil
        expect(@order_form).to be_valid
      end
    end

    context '商品購入ができない時' do
      it 'tokenが空だと購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空の場合は購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空の場合は購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors[:item_id]).to include("can't be blank")
      end

      it 'postal_codeが空の場合は購入できない' do
        @order_form.postal_code = nil
        @order_form.valid?
        expect(@order_form.errors[:postal_code]).to include("can't be blank")
      end

      it 'postal_codeにハイフンが含まれない場合は購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors[:postal_code]).to include('must be in the format XXX-XXXX')
      end

      it 'region_idが1の場合は購入できない' do
        @order_form.region_id = 1
        @order_form.valid?
        expect(@order_form.errors[:region_id]).to include("can't be blank")
      end

      it 'cityが空の場合は購入できない' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors[:city]).to include("can't be blank")
      end

      it 'house_numberが空の場合は購入できない' do
        @order_form.house_number = nil
        @order_form.valid?
        expect(@order_form.errors[:house_number]).to include("can't be blank")
      end

      it 'phone_numberが空の場合は購入できない' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors[:phone_number]).to include("can't be blank")
      end

      it 'phone_numberが9桁以下の場合は購入できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it 'phone_numberが12桁以上の場合は購入できない' do
        @order_form.phone_number = '123456789012'
        @order_form.valid?
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it 'phone_numberに半角数字以外が含まれている場合は購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it 'phone_numberが全角の場合は購入できない' do
        @order_form.phone_number = '０９０１２３４５６７８'
        @order_form.valid?
        expect(@order_form.errors[:phone_number]).to include('must be 10 or 11 digits')
      end
    end
  end
end
