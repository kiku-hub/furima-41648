class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :region_id, :city, :house_number, :building_name, :phone_number

  validates :user_id, :item_id, :postal_code, :region_id, :city, :house_number, :phone_number, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はXXX-XXXXの形式で入力してください' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }

  def save
    return false unless valid?

    # Orderテーブルにデータを保存
    order = Order.create(user_id: user_id, item_id: item_id)

    # Addressテーブルにデータを保存
    Address.create(postal_code: postal_code, region_id: region_id, city: city, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
