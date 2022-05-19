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

        before {@recipe.save}

        it 'should be valid with valid attributes' do
            @recipe.name = 'Recipe'
            @recipe.description = 'Description'
            @recipe.cooking_time = '10'
            @recipe.user_id = @user.id
            @recipe.preparation_time = '10'
            expect(@recipe).to be_valid
        end

       
    end
end