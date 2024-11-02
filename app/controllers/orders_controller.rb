class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params.merge(user_id: current_user.id, item_id: @item.id))
    if @order_form.valid?
      endprocess_payment(@order_form)
      @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def process_payment(order_form)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,         # 商品の価格（@itemから取得）
      card: order_form.token,      # カードトークン
      currency: 'jpy'              # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :region_id, :city, :house_number,
                                       :building_name, :phone_number).merge(token: params[:token])
  end
end
