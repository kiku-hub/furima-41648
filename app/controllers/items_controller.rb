class ItemsController < ApplicationController
  # 特定のアクションに対してユーザー認証を適用
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user, only: [:edit, :update, :destroy]

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

  # 商品詳細ページを表示するアクション
  def show
  end

  # 商品情報編集ページを表示するアクション
  def edit
  end

  # 商品情報を更新するアクション
  def update
    # 画像が選択されていない場合は、画像の更新をスキップ
    params[:item].delete(:image) if params[:item][:image].blank?

    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      flash.now[:alert] = '商品の更新に失敗しました。必須項目を確認してください。'
      render :edit, status: :unprocessable_entity
    end
  end

  # 商品を削除するアクション
  def destroy
    if @item.destroy
      redirect_to root_path, notice: '商品が削除されました。'
    else
      redirect_to item_path(@item), alert: '商品の削除に失敗しました。'
    end
  end

  private

  # 共通の@itemセットメソッド
  def set_item
    @item = Item.find(params[:id])
  end

  # 他のユーザーが商品編集や削除をできないようにするためのメソッド
  def ensure_user
    redirect_to root_path, alert: '他のユーザーの商品は編集できません' unless @item.user == current_user
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
