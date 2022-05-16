class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.text :name
      t.string :measurement_unit
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
