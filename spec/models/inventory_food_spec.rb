require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  describe 'Validation for inventory_food model' do
    before(:each) do
      @user = User.create(
        email: 'test@mail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @inventory = Inventory.create(
        name: 'Inventory',
        description: 'Inventory',
        user_id: @user.id
      )
      @food = Food.create(
        name: 'Food',
        measurement_unit: 'g',
        price: '10',
        user_id: @user.id
      )
      @inventory_food = InventoryFood.new(
        inventory_id: @inventory.id,
        food_id: @food.id,
        quantity: '10'
      )
    end

    before { @inventory_food.save }

    it 'should be valid with valid attributes' do
      @inventory_food.inventory_id = @inventory.id
      @inventory_food.food_id = @food.id
      @inventory_food.quantity = '10'
      expect(@inventory_food).to be_valid
    end

    it 'should not be valid without inventory_id' do
      @inventory_food.inventory_id = nil
      @inventory_food.food_id = @food.id
      @inventory_food.quantity = '10'
      expect(@inventory_food).to_not be_valid
    end

    it 'should not be valid without food_id' do
      @inventory_food.food_id = nil
      expect(@inventory_food).to_not be_valid
    end

    it 'should not be valid without quantity' do
      @inventory_food.quantity = nil
      expect(@inventory_food).to_not be_valid
    end

    it 'id should be a number' do
      @inventory_food.id = 1
      expect(@inventory_food).to be_valid
    end
  end
end
