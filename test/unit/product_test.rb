require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products    #load fixture data from products.yml into the db table.
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?               # should return true, since empty product should be invalid
    assert product.errors[:title].any?    # any tests if theres an error assoc w a partic attribute
    assert product.errors[:description].any? 
    assert product.errors[:price].any? 
    assert product.errors[:image_url].any?
  end
  
  #perform price validation: check -1, 0 and 1, and confirm error message
  test "product price must be positive" do 
    product = Product.new(:title	=> "My Book Title", 
                          :description => "yyy", 
                          :image_url	=> "zzz.jpg")
    product.price = -1 
    assert product.invalid? 
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
  
    product.price = 0 
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
  
    product.price = 1
    assert product.valid?
  end
  
  def new_product(image_url)
    Product.new(:title => "My Title",
                :description => "yyy",
                :price  => 1,
                :image_url => image_url)
  end
  
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif } 
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |url_name|
      assert new_product(url_name).valid?, "#{url_name} shouldn't be invalid"
    end
      
    bad.each do |url_name|
      assert new_product(url_name).invalid?, "#{url_name} should be invalid"
    end
  end
  
  #now do a test with the fixture
  test "product is not valid without a unique title" do 
    product = Product.new(:title	=> products(:ruby).title,
                          :description => "yyy", 
                          :price	=> 1, 
                          :image_url	=> "fred.gif")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end
  
end
