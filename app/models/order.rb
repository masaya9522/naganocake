class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  

  
  # #validates :postal_code, presence: true
  # validates :address, presence: true
  # validates :name, presence: true
  # validates :payment_method, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }

  
  
  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end

  def calculation(order)
    sum=0
    order.order_items.each do |order_item|
    sum+=  order_item.tax_price*order_item.amount
    end
    
  return sum
  
  end
  
end