class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_product(product_id, qty = 1)
    item = cart_items.find_by(product_id: product_id)
    if item
      item.increment(:quantity, qty)
      item.save
    else
      cart_items.create(product_id: product_id, quantity: qty)
    end
  end

  def total_price_cents
    cart_items.includes(:product).sum(&:total_price_cents)
  end

  def total_price
    total_price_cents / 100.0
  end
end
