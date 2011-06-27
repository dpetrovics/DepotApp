class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private   #means the methods below are only available to other cntrlrs, it is not availble as
            # an action on the controller
  
    def current_cart
      #looks in the carts table to find the cart with cart.id (which is stored in session[:cart_id])
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound   #if the cart_id isnt found or is nil, create a new cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
