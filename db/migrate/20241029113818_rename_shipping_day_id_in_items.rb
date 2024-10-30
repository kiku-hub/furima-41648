class RenameShippingDayIdInItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :shopping_day_id, :shopping_day_id
  end
end
