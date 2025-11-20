class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    add_to_cart
  end

  def add
    add_to_cart
  end

  def destroy
    remove_from_cart
  end

  def remove
    remove_from_cart
  end

  private

  def add_to_cart
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

  def remove_from_cart
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to root_path, notice: "Item removed from cart."
  end
end