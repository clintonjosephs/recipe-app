require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Validation for recipe model' do
    before(:each) do
      @user = User.create(
        email: 'test@mail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @recipe = Recipe.new(
        name: 'Recipe',
        description: 'Description',
        user_id: @user.id
      )
    end

    before { @recipe.save }

    it 'should be valid with valid attributes' do
      @recipe.name = 'Recipe'
      @recipe.description = 'Description'
      @recipe.cooking_time = '10'
      @recipe.user_id = @user.id
      @recipe.preparation_time = '10'
      expect(@recipe).to be_valid
    end

    it 'should not be valid without name' do
      @recipe.name = nil
      @recipe.description = 'Description'
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid without description' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid without user_id' do
      @recipe.user_id = nil
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid without user' do
      @user.destroy
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with name longer than 100 characters' do
      @recipe.name = 'a' * 101
      expect(@recipe).to_not be_valid
    end

    it 'should not be valid with description longer than 255 characters' do
      @recipe.description = 'a' * 256
      expect(@recipe).to_not be_valid
    end
  end
end
