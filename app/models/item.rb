class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :order_details
  has_one_attached :image
  belongs_to :genre
end
