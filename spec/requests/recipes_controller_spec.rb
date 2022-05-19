require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  before(:each) do
    User.destroy_all
    Recipe.destroy_all
    @user = FactoryBot.create(:user)
    @recipe = FactoryBot.create(:recipe, user: @user, public: false)
  end

  describe 'Get recipes' do
    before(:example) { get('/recipes') }
    it 'redirects when anonymous user tries to access recipes' do
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'Get recipe details' do
    before(:example) { get("/recipes/#{@recipe.id}") }

    it 'succeeds in getting recipe details' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the recipe details template' do
      expect(response).to render_template('recipes/show')
    end
  end
end
