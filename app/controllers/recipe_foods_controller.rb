class RecipeFoodsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    setup
  end

  def edit
    setup
    @recipe_food = RecipeFood.find(params[:id])
  end

  def create
    setup
    recipe_food = RecipeFood.new(recipe_food_params)
    recipe_food.recipe_id = params[:recipe_id]
    if recipe_food.save
      flash[:success] = 'Food was successfully added to recipe.'
    else
      flash[:danger] = 'Food was not added to recipe because <ul class="error-list">'
      recipe_food.errors.full_messages.each do |msg|
        flash[:danger] += "<li>#{msg}</li>"
      end
      flash[:danger] += '</ul>'
    end
    redirect_to new_recipe_recipe_food_path(params[:recipe_id])
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Recipe food deleted successfully'
        redirect_back_or_to({ action: 'show', id: params[:recipe_id] })
      end
    end
  end

  def update
    recipe_food = RecipeFood.find(params[:id])

    if recipe_food.update(recipe_food_update)
      flash[:success] = "quantity for #{recipe_food.food.name} was successfully updated."
    else
      flash[:danger] = 'operation failed <ul class="error-list">'
      recipe_food.errors.full_messages.each do |msg|
        flash[:danger] += "<li>#{msg}</li>"
      end
      flash[:danger] += '</ul>'
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  def setup
    @recipe_food = RecipeFood.new
    @recipe_food_ids = RecipeFood.all.where(recipe_id: params[:recipe_id]).pluck(:food_id)
    @foods = Food.all.where(user_id: current_user.id).where.not(id: @recipe_food_ids).order(name: :asc)
    @recipe = Recipe.find(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end

  def recipe_food_update
    params.require(:recipe_food).permit(:quantity)
  end
end
