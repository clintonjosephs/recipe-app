class RecipeFoodController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @recipe_foods = RecipeFood.all
    end

    def new
        @recipe_food = RecipeFood.new
    end

    def create
        @recipe_food = RecipeFood.new(recipe_food_params)
    
        respond_to do |format|
          format.html do
            if @recipe_food.save
              flash[:success] = 'Recipe created successfully'
              redirect_back_or_to({ action: 'show', id: params[:recipe_id] })
            else
              flash.now[:error] = 'Error: Recipe could not be created'
              render :new
            end
          end
        end
    end

    def destroy
        @recipe_food = RecipeFood.find(params[:id])
        @recipe_food.destroy
        respond_to do |format|
          format.html do
            flash[:success] = 'Recipe deleted successfully'
            redirect_back_or_to({ action: 'show', id: params[:recipe_id] })
          end
        end
    end

    private

    def recipe_food_params
        params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
    end
end
