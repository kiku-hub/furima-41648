FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' } # 郵便番号の例
    region_id { 2 } # 都道府県ID (例: 東京都)
    city { '東京都' } # 市区町村
    house_number { '1-1-1' } # 番地
    building_name { '青山マンション' } # 建物名
    phone_number { '09012345678' } # 電話番号
    token { 'tok_abcdefghijk00000000000000000' } # テスト用のトークン
  end
end
