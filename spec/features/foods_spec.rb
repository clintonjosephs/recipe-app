require 'rails_helper'

RSpec.describe 'Food List', type: :feature do
  before(:all) do
    User.destroy_all
    Food.destroy_all
    @user = FactoryBot.create(:user)
    m = 5
    while m > 0
      FactoryBot.create(:food, name: "#{Faker::Food.name}#{m}", user: @user)
      m -= 1
    end
  end

  before(:each) do
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Log in')
    visit(foods_path)
  end

  scenario 'confirm that we are on the foods show page' do
    expect(page).to have_current_path(foods_path)
  end

  scenario 'confirm that all foods that belong to the user are displayed' do
    expect(page).to have_css('tr', count: 6)
  end

  scenario 'confirm that all foods have delete buttons' do
    expect(page).to have_link('Delete', count: 5)
  end

  scenario 'confirm that all food names are properly displayed' do
    @food = Food.all
    @food.each do |food|
      expect(page).to have_content(food.name)
    end
  end
end
