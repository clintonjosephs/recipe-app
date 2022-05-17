class RecipesController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes.all
  end

  def show
    @user = current_user
    @recipe = @user.recipes.all
  end

  def new
    @user = current_user
    @recipe = @user.recipes.new
    # @foods = Food.find(current_user.id)
  end

  def create
    @user = current_user
    @recipe = @user.recipes.new(recipe_params)
    respond_to do |format|
      format.html do
        if @recipe.save
          flash[:success] = 'Recipe created successfully'
          redirect_to recipes_url
        else
          flash.now[:error] = 'Error: Recipe could not be created'
          render :new
        end
      end
    end
  end

  def destroy
    @user = current_user
    @recipe = @user.recipes.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipe_path, notice: 'Recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description, :image)
  end
end
