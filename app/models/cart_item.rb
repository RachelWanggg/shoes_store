class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price_cents
    quantity.to_i * product.price_cents.to_i
  end

  def total_price
    total_price_cents / 100.0
  end
end
