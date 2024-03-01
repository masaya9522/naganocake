class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

def sum_price
  self.tax_price * self.amount
end

end
