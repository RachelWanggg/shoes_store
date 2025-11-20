class ProductsController < ApplicationController
  def index
    @query = params[:q]
    @min_price = params[:min_price]
    @max_price = params[:max_price]
    
    @products = Product.search(@query, min_price: @min_price, max_price: @max_price)
                       .order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end
end
