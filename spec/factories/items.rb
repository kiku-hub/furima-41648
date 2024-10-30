FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name } # 商品名
    description { Faker::Lorem.sentence } # 商品の説明
    price { rand(300..9_999_999) } # 価格は300以上9,999,999以下のランダムな整数
    category_id { 2 }                                   # カテゴリーID（1以外の無効値）
    condition_id { 2 }                                  # 商品の状態ID（1以外の無効値）
    shopping_fee_id { 2 }                               # 配送料の負担ID（1以外の無効値）
    region_id { 2 }                                     # 発送元地域ID（1以外の無効値）
    shopping_day_id { 2 }                               # 発送までの日数ID（1以外の無効値）
    association :user                                   # ユーザーの関連付け

    # 画像ファイルの添付処理
    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('public/images/linux.jpeg')), # テスト用の画像ファイルパス
        filename: 'linux.jpeg',                                     # ファイル名
        content_type: 'image/jpeg' # コンテンツタイプ
      )
    end
  end
end
