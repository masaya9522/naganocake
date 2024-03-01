class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    is_updated = true
    if @order_item.update(order_item_params)
      @order.update(status: 3) if @order_item.status == "in_production"

      @order.order_items.each do |order_item|
        if order_item.status != "production_completed"
          is_updated = false
        end
      end
      @order.update(status: 4) if is_updated
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:status)
  end

end
