class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.includes([:customer_id])
    @cart_item = CartItem.find(params[:item_id])
    #@total_price = Item.total_price
  end

  def create
    binding.pry
    @item = Item.find(cart_item_params[:item_id])
  end

  def update
    @cart_item = CartItem.find(params[:id])
  end

  def destroy

  end

    private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
