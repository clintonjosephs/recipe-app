class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods, dependent: :destroy
  validates_uniqueness_of :name
  validates :name, presence: true, length: { maximum: 100 }
end
