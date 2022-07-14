class Public::OrdersController < ApplicationController
  def new
    @addresses = Address.all
    @order = Order.new
  end

  def confirm
  end

  def complete
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
  end

    private

  def order_params
    params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address,
    :delivery_name, :payment_method, :is_active, :amount_billed, :postage  )
  end
end
