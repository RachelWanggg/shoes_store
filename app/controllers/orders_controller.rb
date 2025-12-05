class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders
  end

  def new
    @order = current_user.orders.build
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
    
    
  def create
    ActiveRecord::Base.transaction do
      # Validate stock before creating order
      current_cart.cart_items.each do |item|
        if item.quantity > item.product.stock
          raise ActiveRecord::Rollback, "Not enough stock"
        end
      end

      # Calculate total and create order first
      @order = current_user.orders.create!(
        total_cents: current_cart.total_price_cents,
        status: 'pending'
      )

      # Now create order items (order is saved, so this works)
      current_cart.cart_items.each do |item|
        @order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price_cents: item.product.price_cents
        )
  
        # Update product stock
        item.product.update!(
          stock: item.product.stock - item.quantity
        )
  
        # Prevent negative stock
        if item.product.stock < 0
          raise ActiveRecord::Rollback, "Not enough stock"
        end
      end
  
      # Clear cart
      current_cart.cart_items.destroy_all
    end
  
    redirect_to @order, notice: "Order placed successfully!"
  rescue => e
    redirect_to cart_path, alert: "Checkout error: #{e.message}"
  end

  private

  def order_params
    params.fetch(:order, {}).permit(:status, :total_cents)
  end
end