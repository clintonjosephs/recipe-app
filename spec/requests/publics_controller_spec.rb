require 'rails_helper'

RSpec.describe 'Public recipes', type: :request do
  before(:each) do
    User.destroy_all
    Recipe.destroy_all
    @user = FactoryBot.create(:user)
    @recipe = FactoryBot.create(:recipe, user: @user, public: true)
  end

  describe 'GET public recipies' do
    before(:example) { get('/publics') }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the sign_in template' do
      expect(response).to render_template('publics/index')
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include 'Public Recipes'
    end
  end
end
