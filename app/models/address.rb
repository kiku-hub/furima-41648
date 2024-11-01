class Address < ApplicationRecord
  belongs_to :order # Orderとの関連

  validates :postal_code, presence: true
  validates :region_id, presence: true # area_idをregion_idに修正
  validates :city, presence: true           # municipalitiesをcityに修正
  validates :house_number, presence: true   # addressをhouse_numberに修正
  validates :phone_number, presence: true

  # 追加のバリデーションやメソッドがあればここに記述
end
