require 'rails_helper'

RSpec.describe 'New inventory form', type: :feature do
  before(:each) do
    User.destroy_all
    Inventory.destroy_all
    @user = FactoryBot.create(:user)
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Log in')
    visit(new_inventory_path)
  end

  scenario 'confirm that we are on the new food page' do
    expect(page).to have_current_path(new_inventory_path)
  end

  scenario 'create a new inventory' do
    within '.shadow form' do
      fill_in('inventory_name', with: 'House inventory')
      fill_in('inventory_description', with: 'This is a house inventory')
    end
    click_button('Add Inventory')
    expect(page).to have_current_path(inventories_path)
    expect(page).to have_content('House inventory')
  end
end
