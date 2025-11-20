class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
    
    
  def create
    cart = current_cart
    if cart.cart_items.empty?
      redirect_to products_path, alert: "Cart is empty" and return
    end


    order = current_user.orders.create(total_cents: cart.cart_items.sum {|i| i.quantity * i.product.price_cents }, status: 'pending')


    cart.cart_items.each do |item|
      order.order_items.create(product: item.product, quantity: item.quantity, price_cents: item.product.price_cents)
    end


    cart.cart_items.destroy_all
    session[:cart_id] = nil
    redirect_to order_path(order), notice: "Order placed successfully!"
  end
end