class RemoveShoppingFeeIdFromItems < ActiveRecord::Migration[7.0]
    def change
      remove_column :items, :shopping_fee_id, :integer
    end
