class Item < ApplicationRecord
  has_one_attached :image

  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :order_details
  belongs_to :genre


def favorited_by?(user)
    favorites.exists?(user_id: user.id)
end
  ## 消費税を求めるメソッド
def with_tax_price
    (price * 1.1).floor
end

end
