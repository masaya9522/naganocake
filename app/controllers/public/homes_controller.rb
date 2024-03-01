class Public::HomesController < ApplicationController
  def about
    
  end
  
  def top
    @items = Item.order(created_at: :desc).limit(4)
  end
end
