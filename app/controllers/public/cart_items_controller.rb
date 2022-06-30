class Public::CartItemsController < ApplicationController
  before_action :setup_cart_item!, only: %i[add_item update_item delete_item]

  def index  # カート内アイテムの表示
    @cart_items = current_customer.cart_items.includes([:customer_id])
    #includes=関連するテーブルをまとめて取得
    @cart_item = CartItem.find(params[:item_id])
    #@total_price = Item.total_price
  end

  def create # アイテムの追加
    @cart_item = CartItem.new(cart_item_params)
  end

  def update # アイテムの更新

  end

  def destroy # アイテムの削除

  end

    private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
