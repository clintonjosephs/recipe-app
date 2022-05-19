require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'Validation for recipe_food model' do
    subject do
      @user = User.create(
        email: 'test@mail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )

      @food = Food.create(
        name: 'Food',
        measurement_unit: 'g',
        price: 10,
        user_id: @user.id
      )

      @recipe = Recipe.create(
        name: 'Recipe',
        description: 'Recipe',
        user_id: @user.id,
        cooking_time: '30',
        preparation_time: '30'
      )
      @recipe_food = RecipeFood.create(
        recipe_id: @recipe.id,
        food_id: @food.id,
        quantity: 10
      )
    end

    before(:each) { subject.save }

    it 'should be valid with valid attributes' do
      @recipe_food.recipe_id = @recipe.id
      @recipe_food.food_id = @food.id
      @recipe_food.quantity = 10
      expect(@recipe_food).to be_valid
    end

    it 'should not be valid without recipe_id' do
      @recipe_food.recipe_id = nil
      @recipe_food.food_id = @food.id
      @recipe_food.quantity = 10
      expect(@recipe_food).to_not be_valid
    end

    it 'should not be valid without food_id' do
      @recipe_food.recipe_id = @recipe.id
      @recipe_food.food_id = nil
      @recipe_food.quantity = 10
      expect(@recipe_food).to_not be_valid
    end

    it 'should not be valid without quantity' do
      @recipe_food.recipe_id = @recipe.id
      @recipe_food.food_id = @food.id
      @recipe_food.quantity = nil
      expect(@recipe_food).to_not be_valid
    end
  end
end
