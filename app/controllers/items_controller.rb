class ItemsController < ApplicationController
  # 特定のアクションに対してユーザー認証を適用
  before_action :authenticate_user!, only: [:new, :create]

  # トップページ用の処理（必要に応じて記述）
  def index
    # トップページに表示するアイテムを取得（例：最新の出品商品）
    @items = Item.all.order(created_at: :desc)
  end

  # 商品出品ページを表示するアクション
  def new
    @item = Item.new
  end

  # 商品情報を保存するアクション
  def create
    @item = Item.new(item_params)
    @item.user = current_user # ログイン中のユーザー情報をitemに紐付け

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
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end
end
