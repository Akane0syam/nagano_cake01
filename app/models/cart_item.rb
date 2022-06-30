class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :items

# カート内の商品合計に利用
  def sum_of_price
    product.price * quantity
  end

end
