class StoreController < ApplicationController
  def index
    @products = Product.all
    @index_view_count = increment_store_index_count
  end

end
