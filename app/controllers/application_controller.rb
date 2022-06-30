class ApplicationController < ActionController::Base
#before_action :configure_permitted_parameters, if: :devise_controller?
protect_from_forgery with: :exception

helper_method :current_cart_item

  def current_cart_item
    if current_customer
      # ユーザーとカートの紐付け
      current_cart_item = current_customer.cart || current_customer.create_cart_item!
    else
      # セッションとアイテムの紐付け
      current_cart_item = CartItem.find_by(id: session[:item_id]) || CartItem.create
      session[:cart_id] ||= current_cart.id
    end
    current_cart_item
  end
end
