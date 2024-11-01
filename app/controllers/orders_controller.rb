class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :set_regions, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params.merge(user_id: current_user.id, item_id: @item.id))

    if @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      # バリデーションエラーのメッセージを取得
      flash.now[:alert] = @order_form.errors.full_messages.join(', ')
      render :index
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
                                       :building_name, :phone_number) # user_idとitem_idはここから除外
  end
end
