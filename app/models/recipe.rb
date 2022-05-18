class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :user_id, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true

  has_one_attached :image
end
