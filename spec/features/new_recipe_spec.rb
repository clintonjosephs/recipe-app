require 'rails_helper'

RSpec.describe 'New recipe form', type: :feature do
  before(:each) do
    User.destroy_all
    Recipe.destroy_all
    @user = FactoryBot.create(:user)
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Log in')
    visit(new_recipe_path)
  end

  scenario 'confirm that we are on the new recipe page' do
    expect(page).to have_current_path(new_recipe_path)
  end

  scenario 'create a new recipe' do
    within '.inventory-card form' do
      fill_in('recipe_name', with: 'New Recipe')
      fill_in('recipe_description', with: '1. Mix ingredients. 2. Bake at 350 degrees for 30 minutes.')
      fill_in('recipe_preparation_time', with: 10)
      fill_in('recipe_cooking_time', with: 10)
      check('recipe_public')
    end
    click_button('Create Recipe')
    expect(page).to have_current_path(recipes_path)
    expect(page).to have_content('Recipe created successfully')
  end
end
