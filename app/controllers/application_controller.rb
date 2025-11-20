class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    return unless current_user

    current_user.cart || current_user.create_cart!
  end
end
