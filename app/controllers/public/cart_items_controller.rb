class Public::CartItemsController < ApplicationController

  def index  # カート内アイテムの表示
    @cart_items = current_customer.cart_items
  end

  def create # アイテムの追加
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items_path
  end

  def update # アイテムの更新
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
       redirect_to public_cart_items_path
    else
      render "index"
    end
  end

  def destroy # アイテムの削除
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

    private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
