class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private   #means the methods below are only available to other cntrlrs, it is not availble as
            # an action on the controller
  
    def current_cart
      Cart.find(session[:cart_id])   #get the :cart_id from session, and return corresponding cart
    rescue ActiveRecord::RecordNotFound   #if the cart_id isnt found or is nil, create a new cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
