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
end