class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
  end

  def empty
    current_cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Cart emptied!"
  end

  def checkout
    cart = current_cart
    order = Order.create(user: current_user, total_cents: cart.total_cents)
    cart.cart_items.each do |ci|
      order.order_items.create(
        product: ci.product,
        quantity: ci.quantity,
        unit_price_cents: ci.product.price_cents
      )
    end
    cart.destroy
    session[:cart_id] = nil
    redirect_to order_path(order), notice: "Order placed!"
  end
end
