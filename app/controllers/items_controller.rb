class ItemsController < ApplicationController
  # 特定のアクションに対してユーザー認証を適用
  before_action :authenticate_user!, only: [:new, :create, :edit]

  # トップページ用の処理
  def index
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
      # バリデーションエラー時の処理
      flash.now[:alert] = '商品の出品に失敗しました。必須項目を確認してください。'
      render :new, status: :unprocessable_entity, local: true
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_user
    return if @item.user == current_user

    redirect_to root_path, alert: '他のユーザーの商品は編集できません'
  end

  # ストロングパラメータ
  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :category_id,
      :condition_id,
      :shopping_fee_id,
      :region_id,
      :shopping_day_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
