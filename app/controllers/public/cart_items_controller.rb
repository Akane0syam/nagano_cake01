class Public::CartItemsController < ApplicationController
  def index
    @cart_items
  end
  def create
  end
  def update
  end

    private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
