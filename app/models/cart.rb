class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def total_price_cents
    cart_items.includes(:product).sum(&:total_price_cents)
  end

  def total_price
    total_price_cents / 100.0
  end
end
