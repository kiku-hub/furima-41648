class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_not_allowed, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params.merge(user_id: current_user.id, item_id: @item.id))
    if @order_form.valid?
      process_payment(@order_form)
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
      amount: @item.price,
      card: order_form.token,
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :region_id, :city, :house_number,
                                       :building_name, :phone_number).merge(token: params[:token])
  end

  def redirect_if_not_allowed
    # 出品者自身または売却済み商品の場合はトップページにリダイレクト
    return unless @item.user_id == current_user.id || @item.order.present?

    redirect_to root_path, alert: 'この商品は購入できません。'
  end
end
