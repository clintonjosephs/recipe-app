class RecipesController < ApplicationController
  def index; end

  def public_recipes
    @recipes = Recipe.includes(:recipe_foods).where(public: true).order('created_at DESC')
  end
end
