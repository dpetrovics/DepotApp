class LineItem < ActiveRecord::Base
  #rows in line item table are children of rows in carts / products tables
  #means line item cant exist wout corresponding cart / product rows
  belongs_to :product
  belongs_to :cart
end
