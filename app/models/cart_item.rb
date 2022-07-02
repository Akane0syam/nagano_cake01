class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

# カート内の商品合計に利用
  def subtotal
    item.with_tax_price * amount
  end

end
