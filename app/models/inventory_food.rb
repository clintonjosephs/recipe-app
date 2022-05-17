class InventoryFood < ApplicationRecord
  belongs_to :food
  belongs_to :inventory

  validates :food_id, presence: true
  validates :inventory_id, presence: true
end
