class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart
  has_many :orders

  after_create :ensure_cart

  private

  def ensure_cart
    create_cart!
  end
end
