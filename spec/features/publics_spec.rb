require 'rails_helper'

RSpec.describe 'Public recipes', type: :feature do
  before do
    User.destroy_all
    Recipe.destroy_all
    @user = FactoryBot.create(:user)
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
  end

  scenario 'confirm that we are in the root path (publics)' do
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Public Recipes')
  end

  scenario 'confirm that we can see public recipes displayed in page' do
    expect(page).to have_css('div.public-card', count: 5)
  end

  scenario 'confirm that public card images are displayed' do
    expect(page).to have_css('div.public-card img', count: 5)
  end

  scenario 'all the recipes names are displayed' do
    expect(page).to have_css('div.public-card h5', count: 5)
    @public_recipes = Recipe.where(public: true)
    @public_recipes.each do |recipe|
      expect(page).to have_content(recipe.name)
    end
  end

  scenario 'confirm that the public card links to the recipe details page' do
    @public_recipes = Recipe.where(public: true)
    @public_recipes.each do |recipe|
      expect(page).to have_link('View Recipe', href: recipe_path(recipe))
    end
  end

  scenario 'confirm that when a recipe is clicked, the user is redirected to the recipe details page' do
    @public_recipes = Recipe.where(public: true).first(1)
    click_link('View Recipe', href: recipe_path(@public_recipes[0].id))
    expect(page).to have_current_path(recipe_path(@public_recipes[0].id))
  end
end
