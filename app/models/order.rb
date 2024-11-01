class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address, dependent: :destroy # 注文が削除されたときに住所も削除される

  # バリデーションを追加する場合はここに記述
  validates :user, presence: true # ユーザーが存在することを確認
  validates :item, presence: true # アイテムが存在することを確認
end
