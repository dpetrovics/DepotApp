require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum => 4   #looks for element named a, contained in elem w id side, contained in elem w id columns. (our 4 links)
    assert_select '#main .entry', 3   #should be 3 entries from our test db (fixtures) 
    assert_select 'h3', 'Programming Ruby 1.9' #should be a title with that name
    assert_select '.price', /\$[,\d]+\.\d\d/  #reg expr: $ followed by at least 1 commas or digits, then '.', then 2 digits
  end

end
