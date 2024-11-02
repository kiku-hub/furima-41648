class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :region_id, :city, :house_number, :building_name, :phone_number

  # バリデーション
  validates :user_id, :item_id, :postal_code, :region_id, :city, :house_number, :phone_number, presence: true

  # 郵便番号は「3桁-4桁」の半角文字列のみ
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'must be in the format XXX-XXXX' }

  # 電話番号は10桁以上11桁以内の半角数字のみ
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be 10 or 11 digits' }

  # 都道府県は1以外を選択させる（1は「---」など未選択の状態を表す）
  validates :region_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      # Orderテーブルにデータを保存
      order = Order.create!(user_id: user_id, item_id: item_id)

      # Addressテーブルにデータを保存
      Address.create!(
        postal_code: postal_code,
        region_id: region_id,
        city: city,
        house_number: house_number,
        building_name: building_name,
        phone_number: phone_number,
        order_id: order.id
      )
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, "保存に失敗しました: #{e.message}")
    false
  end
end
