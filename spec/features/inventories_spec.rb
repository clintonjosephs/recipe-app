require 'rails_helper'

RSpec.describe 'Inventories Page', type: :feature do
  before do
    User.destroy_all
    Inventory.destroy_all
    @user = FactoryBot.create(:user)
    m = 5
    while m > 0
      FactoryBot.create(:inventory, name: "Inventory #{m}", user: @user)
      m -= 1
    end
    visit(new_user_session_path)
    within 'form' do
      fill_in('user_email', with: @user.email)
      fill_in('user_password', with: 'secret')
    end
    click_button('Log in')
    visit(inventories_path)
  end

  scenario 'confirm that we are in the inventories show page' do
    expect(page).to have_current_path(inventories_path)
  end

  scenario 'confirm that all inventories that belong to the user are displayed' do
    expect(page).to have_css('div.inventory-card', count: 5)
  end

  scenario 'confirm that all inventory have delete buttons' do
    expect(page).to have_css('a.btn-danger', count: 5)
  end

  scenario 'confirm that once the view button is clicked, the user is redirected to the inventory details page' do
    click_link('View', href: inventory_path(Inventory.first.id))
    expect(page).to have_current_path(inventory_path(Inventory.first.id))
  end
end
