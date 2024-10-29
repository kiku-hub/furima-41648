class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーションの設定
  belongs_to :genre # ジャンルとの関連付け
  belongs_to :user  # ユーザーとの関連付け（必要に応じて追加）

  # バリデーションの設定
  validates :title, presence: { message: 'は必須です' } # タイトルは必須
  validates :text, presence: { message: 'は必須です' } # 本文は必須
  validates :genre_id, presence: { message: 'は必須です' }, numericality: { other_than: 1,  message: "can't be blank" } # ジャンルは必須（1は無効）

  # エラーハンドリングの際の重複したエラーメッセージを防ぐ
  validate :prevent_duplicate_errors

  private

  def prevent_duplicate_errors
    errors.add(:base, '記事情報に誤りがあります。') if errors.any?
  end
end
