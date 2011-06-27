class Product < ActiveRecord::Base
  default_scope :order => 'title'   #will return product lists in alphabetical order
  
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item  #'hook' method
  
  # ensure that there are no line items referencing this product 
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  
  #validation stuff
  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with   => %r{\.(gif|jpg|png)$}i,   # reg exp: $=end of line, i=ignores case
    :message => 'must be a URL for GIF, JPG or PNG image.'
  }
end
