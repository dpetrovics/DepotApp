class Cart < ActiveRecord::Base
  #a cart can have many line items, which are linked to the cart via their cart_id property
  #dependent means that if we destroy a cart, then its line items are destroyed too
  has_many :line_items, :dependent => :destroy  

end
