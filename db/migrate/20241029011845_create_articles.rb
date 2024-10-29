class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.integer :genre_id, null: false   # ActiveHashでジャンルを管理するためのID

      t.timestamps
    end

    # genre_id に関する制約を追加
    add_index :articles, :genre_id
  end
end