class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end
  
  def index
    @orders = Order.all
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save!

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
      @order_detail.save
      end
    # 最後にカートを全て削除する
    @cart_items.destroy_all
    
    redirect_to public_orders_confirm_path
  end

  def confirm
    @order = Order.new(order_params)
    @order.delivery_postal_code = current_customer.postal_code
    @order.delivery_address = current_customer.address
    @order.delivery_name = current_customer.first_name + current_customer.last_name

    # 1（自宅）
    if params[:order][:select_address] == "1"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name

    # 2（配送先一覧）
    elsif params[:order][:select_address] == "2"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    # 3 (新配送先)
    elsif params[:order][:select_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:delivery_name]
      @ship = "1"

    # 有効かどうかの確認
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order_detail = OrderDetail.find(@order.id)
    @item = Item.find(@order_detail.item_id)
  end

  def complete
  end


  
  

    private

  def order_params
    params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address,
    :delivery_name, :payment_method, :is_active, :amount_billed, :postage  )
  end
end
