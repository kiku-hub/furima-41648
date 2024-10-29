class ItemsController < ApplicationController
  # 特定のアクションに対してユーザー認証を適用
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # トップページ用の処理（必要に応じて記述）
  end

  # 商品出品ページを表示するアクション
  def new
    @item = Item.new
  end

  # 商品情報を保存するアクション
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品が完了しました。'
    else
      render :new # エラーハンドリング: 失敗した場合は出品ページに戻る
    end
  end

  private

  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :region_id,
                                 :shipping_day_id, :price)
  end
end
