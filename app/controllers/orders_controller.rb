class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :set_regions, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params.merge(user_id: current_user.id, item_id: @item.id))

    if @order_form.valid?
      Payjp.api_key = 'sk_test_b1dd0557f3d25b612cffd37a' # 自身のPAY.JPテスト秘密鍵を記述しましょう

      # 決済処理
      begin
        Payjp::Charge.create(
          amount: @item.price,          # 商品の値段（@itemから取得）
          card: order_params[:token],   # カードトークン
          currency: 'jpy'               # 通貨の種類（日本円）
        )

        # 注文を保存
        @order_form.save
        redirect_to root_path, notice: '購入が完了しました'
      rescue Payjp::InvalidRequestError => e
        # 決済処理失敗時のエラー処理
        flash.now[:alert] = "決済処理に失敗しました: #{e.message}"
        render :index, status: :unprocessable_entity, locals: { order_form: @order_form } # @order_formを渡す
      end
    else
      # バリデーションエラー時の処理
      flash.now[:alert] = @order_form.errors.full_messages.join(', ')
      render :index, status: :unprocessable_entity, locals: { order_form: @order_form } # @order_formを渡す
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_regions
    @regions = Region.all
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :region_id, :city, :house_number,
                                       :building_name, :phone_number).merge(token: params[:token])
  end
end
