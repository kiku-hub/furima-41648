class OrdersController < ApplicationController
  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_form = OrderForm.new(order_params)

    if @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:user_id, :item_id, :postal_code, :region_id, :city, :house_number, :building_name,
                                       :phone_number)
  end
end
