require 'rails_helper'

RSpec.describe 'New food form', type: :feature do
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
    visit(new_food_path)
  end

  scenario 'confirm that we are on the new food page' do
    expect(page).to have_current_path(new_food_path)
  end

  scenario 'create a new food' do
    within '.shadow form' do
      fill_in('food_name', with: 'New Food')
      select('grams', from: 'food_measurement_unit')
      fill_in('food_price', with: 10)
    end
    click_button('Add Food')
    expect(page).to have_current_path(foods_path)
    expect(page).to have_content('Food was successfully created.')
  end
end
