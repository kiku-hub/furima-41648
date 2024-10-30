class Item < ApplicationRecord
  # ActiveHashを利用するための設定
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーションの設定
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shopping_fee
  belongs_to :region
  belongs_to :shopping_day
  # 注文との関連を追加
  has_one :order
  has_one_attached :image

  # バリデーションの設定
  validates :image, presence: { message: 'は必須です' }
  validates :name, presence: { message: 'は必須です' }
  validates :description, presence: { message: 'は必須です' }

  validates :category_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' }
  validates :condition_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' }
  validates :shopping_fee_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' }
  validates :region_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' }
  validates :shopping_day_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' }

  validates :price, presence: { message: 'は必須です' },
                    numericality: {
                      only_integer: true,
                      greater_than: 299,
                      less_than: 10_000_000,
                      message: 'は¥300以上の値段にしてください'
                    }

  # 売り切れかどうかを判断するメソッド
  def sold_out?
    order.present? # 注文が存在すれば売り切れと判断
  end
end
