class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :email, :telephone_number, :is_active)
  end

end
