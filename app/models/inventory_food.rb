class InventoryFood < ApplicationRecord
  belongs_to :food
  belongs_to :inventory
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :food_id, presence: true
end
