class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
   @order = Order.find(params[:id])
   @order_items = @order.order_items.all   
  end
  
  def update
    @order = Order.find(params[:id])
    is_order_update = true
    if @order.update(order_params)
      if @order.status != "confirm_payment"
        is_order_update = false
      end
      @order.order_items.each do |order_item|
        order_item.update(status: 2) if is_order_update
      end
    end
    redirect_to admin_order_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end

end
