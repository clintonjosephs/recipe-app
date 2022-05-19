require 'rails_helper'

RSpec.describe 'Recipe details', type: :feature do
  before do
    User.destroy_all
    Recipe.destroy_all
    @user = FactoryBot.create(:user)
    FactoryBot.create(:recipe, user: @user, public: false)
    m = 5
    while m > 0
      FactoryBot.create(:recipe, user: @user, public: true)
      m -= 1
    end
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Log in')
    @recipe = Recipe.first
    visit(recipe_path(@recipe.id))
  end

  context 'when the user is in recipe details page' do
    scenario 'redirect to recipe details page' do
      expect(page).to have_current_path(recipe_path(@recipe.id))
    end

    scenario 'confirm that the recipe name are properly displayed' do
      expect(page).to have_content(@recipe.name)
    end

    scenario 'confirm that the recipe description are properly displayed' do
      expect(page).to have_content(@recipe.description)
    end

    scenario 'confirm that the recipe preparation time are properly displayed' do
      expect(page).to have_content("Preparation time: #{@recipe.preparation_time}")
    end

    scenario 'confirm that the recipe cooking time are properly displayed' do
      expect(page).to have_content("Cooking time: #{@recipe.cooking_time}")
    end

    scenario 'confirm that the recipe ingredients are properly displayed' do
      expect(page).to have_css('table')
    end

    scenario 'confirm that there is a link for adding food to recipe' do
      expect(page).to have_link('Add food ingredient', href: new_recipe_recipe_food_path(@recipe.id))
    end

    scenario 'confirm that there is button for generating shopping list' do
      expect(page).to have_button('Generate shopping list')
    end

    scenario 'confirm that when link to add food ingredient is clicked, we are redirected to the new food ingredient page' do
      click_link('Add food ingredient', href: new_recipe_recipe_food_path(@recipe.id))
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe.id))
    end
  end
end
