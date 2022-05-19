require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  before(:each) do
    User.destroy_all
    Inventory.destroy_all
    @user = FactoryBot.create(:user)
    @inventory = FactoryBot.create(:inventory, user: @user)
  end

  describe 'GET inventories' do
    before(:example) { get('/inventories') }
    it 'returns http found' do
      expect(response).to have_http_status(:found)
    end
    it 'should be redirected to sign_in' do
      expect(response).to redirect_to(new_user_session_path)
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include 'redirected'
    end
  end

  describe 'GET inventories show' do
    before(:example) { get("/inventories/#{@inventory.id}") }
    it 'returns http found' do
      expect(response).to have_http_status(:found)
    end
    it 'should be redirected to sign_in' do
      expect(response).to redirect_to(new_user_session_path)
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include 'redirected'
    end
  end
end
