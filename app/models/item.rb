class Item < ApplicationRecord
  # ActiveHashを利用するための設定
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーションの設定
  belongs_to :user
  belongs_to :category # カテゴリーとの関連付け
  belongs_to :condition # 商品の状態との関連付け
  belongs_to :shipping_fee # 配送料の負担との関連付け
  belongs_to :region # 発送元の地域との関連付け
  belongs_to :shipping_day # 発送までの日数との関連付け
  has_one :order
  has_one_attached :image # Active Storageで画像を紐付ける

  # バリデーションの設定
  validates :image, presence: { message: 'は必須です' } # 商品画像は必須
  validates :name, presence: { message: 'は必須です' } # 商品名は必須
  validates :description, presence: { message: 'は必須です' } # 商品の説明は必須

  validates :category_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' } # カテゴリーは必須（1は'---'）
  validates :condition_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' } # 商品の状態は必須（1は無効）
  validates :shipping_fee_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' } # 配送料の負担は必須（1は無効）
  validates :region_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' } # 発送元の地域は必須（1は無効）
  validates :shipping_day_id, presence: { message: 'は必須です' }, numericality: { other_than: 1, message: 'は無効です' } # 発送までの日数は必須（1は無効）

  validates :price, presence: { message: 'は必須です' }, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'は300以上9,999,999以下の整数でなければなりません'
  } # 価格は必須で、300以上9,999,999以下かつ半角数値のみ

  # エラーハンドリングの際の重複したエラーメッセージを防ぐ
  validate :prevent_duplicate_errors

  private

  def prevent_duplicate_errors
    # バリデーションエラーがあればカスタムメッセージを追加
    errors.add(:base, '商品情報に誤りがあります。') if errors.any?
  end
end
