class Cart < ActiveRecord::Base
  #a cart can have many line items, which are linked to the cart via their cart_id property
  #dependent means that if we destroy a cart, then its line items are destroyed too
  has_many :line_items, :dependent => :destroy  

  def add_product(product_id)
    current_item = line_items.where(:product_id => product_id).first
    if (current_item)
      current_item.quantity += 1
    else
      #build a new line item relationship w the cart at one end, and product on the other end
      #the argument is a hash, syntax :foreignkey => value to assign
      current_item = line_items.build(:product_id => product_id)
      #so the above makes a line_item with the correct cart_id (for cart), and product_id (for product)
    end
    current_item
  end
  
  def total_price 
    line_items.to_a.sum { |item| item.total_price }
  end
  
  def total_items
    line_items.sum(:quantity)
  end
  
end
