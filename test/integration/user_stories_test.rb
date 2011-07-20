require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products    #only load the products fixture
  
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
  
    # user goes into the stores index page
    get "/"
    assert_response :success
    assert_template "index"
  
    # they select a product and add it to their cart
    xml_http_request :post, '/line_items', :product_id => ruby_book.id
    assert_response :success
    cart = Cart.find(session[:cart_id]) 
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    #then they check out
    get "/orders/new" 
    assert_response :success 
    assert_template "new"
  
    #users fills out the order form and hits submit order, should get redirected to index
    #this posts the form data, and follows the redirect (to index)
    post_via_redirect "/orders", 
                      :order => { :name	=> "Dave Thomas",
                                  :address => "123 The Street", 
                                  :email	=> "dave@example.com", 
                                  :pay_type => "Check" }
                                
    assert_response :success 
    assert_template "index" 
    cart = Cart.find(session[:cart_id])     #get the cart, and make sure that the line item was removed
    assert_equal 0, cart.line_items.size
  
    #make sure our order details are correct (remember all previous orders have been deleted)
    orders = Order.find(:all) 
    assert_equal 1, orders.size 
    order = orders[0]
  
    assert_equal "Dave Thomas",	order.name 
    assert_equal "123 The Street",	order.address 
    assert_equal "dave@example.com", order.email 
    assert_equal "Check",	order.pay_type
  
    assert_equal 1, order.line_items.size 
    line_item = order.line_items[0] 
    assert_equal ruby_book, line_item.product
  
    #make sure that the email was sent out with the correct details
    mail = ActionMailer::Base.deliveries.last 
    assert_equal ["dpetrovics@gmail.com"], mail.to 
    assert_equal 'David P. <dave@somedomain.com>', mail[:from].value 
    assert_equal "order received!", mail.subject
  end
end
