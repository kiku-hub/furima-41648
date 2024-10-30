require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item) # FactoryBotを使用して、テスト用のアイテムを生成
  end

  describe 'バリデーション' do
    context '商品情報が正しい場合' do
      it '全ての情報が正しければ保存できる' do
        expect(@item).to be_valid
      end
    end

    context '必須項目のバリデーション' do
      it '商品画像がないと無効' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image は必須です')
      end

      it '商品名がないと無効' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Name は必須です')
      end

      it '商品の説明がないと無効' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Description は必須です')
      end
    end

    context 'カテゴリー関連のバリデーション' do
      it 'カテゴリーが1の場合は無効' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category は無効です')
      end

      it 'カテゴリーが空の場合は無効' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category は必須です')
      end
    end

    context '商品の状態関連のバリデーション' do
      it '商品の状態が1の場合は無効' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition は無効です')
      end

      it '商品の状態が空の場合は無効' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition は必須です')
      end
    end

    context '配送料の負担関連のバリデーション' do
      it '配送料の負担が1の場合は無効' do
        @item.shopping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping fee は無効です')
      end

      it '配送料の負担が空の場合は無効' do
        @item.shopping_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping fee は必須です')
      end
    end

    context '発送元の地域関連のバリデーション' do
      it '発送元の地域が1の場合は無効' do
        @item.region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Region は無効です')
      end

      it '発送元の地域が空の場合は無効' do
        @item.region_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Region は必須です')
      end
    end

    context '発送までの日数関連のバリデーション' do
      it '発送までの日数が1の場合は無効' do
        @item.shopping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping day は無効です')
      end

      it '発送までの日数が空の場合は無効' do
        @item.shopping_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Shopping day は必須です')
      end
    end

    context '価格に関するバリデーション' do
      it '価格が空の場合は無効' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は必須です')
      end

      it '価格が300未満の場合は無効' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300以上の値段にしてください')
      end

      it '価格が9,999,999を超える場合は無効' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300以上の値段にしてください')
      end

      it '価格が半角数字以外の場合は無効' do
        @item.price = '三百'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300以上の値段にしてください')
      end
    end

    context 'ユーザーとの関連に関するバリデーション' do
      it 'ユーザーが紐づいていないと無効' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
