class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :order_item_exist?, only: [:confirm_order]

  def new
    @order = Order.new
  end

  def confirm_order
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + ' ' + current_customer.first_name
    @order.postage = 800
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_item = OrderItem.new
      @order_item.order_id = @order.id
      @order_item.item_id = cart_item.item.id
      @order_item.tax_price = cart_item.item.price * 1.1
      @order_item.amount = cart_item.amount
      @order_item.save
    end
    # cart_itemの中の情報を消す(全て)
    current_customer.cart_items.destroy_all
    # redirect先を決める
    redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end



  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id, :postage, :total_payment_amount)
  end

  def order_item_exist?
    if current_customer.cart_items.present? == false
      redirect_to cart_items_path
    end
  end
end
