require 'rails_helper'

RSpec.describe 'Recipe Page', type: :feature do
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
    visit(recipes_path)
  end

  context 'when the user is in the recipes show page' do
    scenario 'confirm that we are in the recipes show page' do
      expect(page).to have_current_path(recipes_path)
    end

    scenario 'confirm that all recipes that belong to the user are displayed' do
      expect(page).to have_css('div.card-body', count: 6)
    end

    scenario 'confirm that all recipes have delete buttons' do
      expect(page).to have_link('Delete', count: 6)
    end

    scenario 'confirm that once the show button is clicked, the user is redirected to the recipe details page' do
      click_link('Show', href: recipe_path(Recipe.first.id))
      expect(page).to have_current_path(recipe_path(Recipe.first.id))
    end
  end
end
