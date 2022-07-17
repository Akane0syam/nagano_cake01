class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end
  
  def index
    @orders = Order.all
  end

  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items

    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

    # total_paymentに請求額を入れる billingはhelperで定義
    @order.total_payment = billing(@order)

    # my_addressに1が入っていれば（自宅）
    if params[:order][:my_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = full_name(current_customer)

    # my_addressに2が入っていれば（配送先一覧）
    elsif params[:order][:my_address] == "2"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    # my_addressに3が入っていれば(新配送先)
    elsif params[:order][:my_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @ship = "1"

    # 有効かどうかの確認
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  def complete
  end


  def create
    @order = current_customer.orders.new(order_params)
    @order.save

    # 情報入力に新規配送先があれば保存
    if params[:order][:ship] =="1"
      current_customer.address.create(address_params)
    end

       # カート商品の情報を注文履歴に移動させる
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      #@order_detail.count = cart_item.count
      #@order_detail.price = cart_item.item.price * cart_item.count 
      @order_detail.save
      end
    # 最後にカートを全て削除する
    @cart_items.destroy_all

    redirect_to public_orders_complete_path
  end
  

    private

  def order_params
    params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address,
    :delivery_name, :payment_method, :is_active, :amount_billed, :postage  )
  end
end
