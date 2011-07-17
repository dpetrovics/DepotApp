class Order < ActiveRecord::Base
  has_many :line_items, :dependent=>:destroy #if we destroy order, destroy its line items
  
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  
  validates :name, :address, :email, :pay_type, :presence=>true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  
  def add_line_items_from_cart(cart) 
    cart.line_items.each do |item|
      item.cart_id = nil    #so the items isnt destroyed when we destroy the cart
      #adds item to the order's line items
      line_items << item    #line_items collection was defined by the has_many declaration
    end 
  end
  
end
