class RenameShippingFeeIdInItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :shopping_fee_id, :shopping_fee_id
  end
end
