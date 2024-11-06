class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code, null: false       # 郵便番号は必須
      t.integer :region_id, null: false       # 都道府県IDは必須
      t.string :city, null: false              # 市区町村名は必須
      t.string :house_number, null: false      # 番地は必須
      t.string :building_name                   # 建物名はオプション
      t.string :phone_number, null: false      # 電話番号は必須
      t.references :order, null: false, foreign_key: true  # 注文IDは必須
      t.timestamps                              # 作成日時・更新日時
    end
  end
end
