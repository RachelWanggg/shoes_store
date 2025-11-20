class CartItemsController < ApplicationController
  before_action :authenticate_user! # Remove this line if not using Devise

  def create
    @product = Product.find(params[:product_id])
    cart = current_cart

    @cart_item = cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity = @cart_item.quantity.to_i + 1

    if @cart_item.save
      redirect_to products_path, notice: "#{@product.name} added to cart!"
    else
      redirect_to products_path, alert: "Could not add item to cart."
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to root_path, notice: "Item removed from cart."
  end
end