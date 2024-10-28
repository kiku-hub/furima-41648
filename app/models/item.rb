class Item < ApplicationRecord
  # アソシエーションの設定
  belongs_to :user
  has_one :order
  has_one_attached :image # Active Storageで画像を紐付ける

  # バリデーションの設定
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_fee_id, presence: true
  validates :region_id, presence: true
  validates :shipping_day_id, presence: true
end
