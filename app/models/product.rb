class Product < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }

  def self.search(query, min_price: nil, max_price: nil)
    products = all

    if query.present?
      normalized_query = "%#{query.downcase}%"
      products = products.where(
        "LOWER(name) LIKE ? OR LOWER(description) LIKE ?",
        normalized_query,
        normalized_query
      )
    end

    if (min_cents = normalize_price(min_price))
      products = products.where("price_cents >= ?", min_cents)
    end

    if (max_cents = normalize_price(max_price))
      products = products.where("price_cents <= ?", max_cents)
    end

    products
  end

  def self.normalize_price(value)
    return nil if value.blank?

    (Float(value) * 100).to_i
  rescue ArgumentError, TypeError
    nil
  end
end