class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private   #means the methods below are only available to other cntrlrs, it is not availble as
            # an action on the controller
  
    def current_cart
      #looks in the carts table to find the cart with cart.id (which is stored in session[:cart_id])
      Cart.find(session[:cart_id])  #we have a session for ea user
    rescue ActiveRecord::RecordNotFound   #if the cart_id isnt found or is nil, create a new cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
    
    def increment_store_index_count
      if (session[:counter].nil?)
        session[:counter]=1
      else
        session[:counter]+=1
      end
      session[:counter]
    end
end
