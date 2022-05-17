class ChangeColumnNameToUniqueInInventory < ActiveRecord::Migration[7.0]
  def change
    change_column :inventories, :name, :string, unique: true
  end
end
