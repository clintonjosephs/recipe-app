class ChangeColumnNameToUniqueInFood < ActiveRecord::Migration[7.0]
  def change
    change_column :foods, :name, :string, unique: true
  end
end
