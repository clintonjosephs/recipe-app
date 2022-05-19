class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all.where(user_id: current_user.id).order(created_at: :desc).with_attached_image
  end

  def new
    @food = Food.new
  end

  def shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])

    # get all inventory foods
    # get all recipe foods
    # get all recipe foods that are not in inventory
    # get all recipe foods that the quantity is higher than the inventory quantity
    # a shopping list is made up of a combination of items
    # that do not exist in the inventory and items that are not enough in the inventory

    @recipe_foods = Food.all.joins('INNER JOIN recipe_foods ON foods.id = recipe_foods.food_id')
      .order(created_at: :desc).select('foods.*, recipe_foods.quantity, recipe_foods.id as recipe_foods_id')
      .where(recipe_foods: { recipe_id: params[:recipe_id] })

    @inventory_foods = Food.all.joins('INNER JOIN inventory_foods ON foods.id = inventory_foods.food_id')
      .select('foods.*, inventory_foods.quantity, inventory_foods.id as inventory_foods_id')
      .where(inventory_foods: { inventory_id: params[:inventory_id] })

    @recipe_food_with_quantity_greater_than_inventory_food_quantity = []
    @recipe_foods.select do |recipe_food|
      @inventory_foods.select do |inventory_food|
        if recipe_food.id == inventory_food.id && recipe_food.quantity > inventory_food.quantity
          recipe_food.quantity = recipe_food.quantity - inventory_food.quantity
          @recipe_food_with_quantity_greater_than_inventory_food_quantity << recipe_food
        end
      end
    end

    @recipe_foods_not_in_inventory = @recipe_foods - @inventory_foods

    @shopping_list = @recipe_foods_not_in_inventory + @recipe_food_with_quantity_greater_than_inventory_food_quantity

    @cost = 0
    @shopping_list.each do |list|
      @cost += list.price * list.quantity
    end
  end

  def create
    new_food = Food.new(food_params)
    new_food.user_id = current_user.id

    if new_food.save
      flash.now[:success] = 'Food was successfully created.'
    else
      flash.now[:danger] = 'Food was not created because <ul class="error-list">'
      new_food.errors.full_messages.each do |msg|
        flash.now[:danger] += "<li>#{msg}</li>"
      end
      flash.now[:danger] += '</ul>'
    end
    render :new
  end

  def destroy
    @foods = Food.all.where(user_id: current_user.id).order(created_at: :desc).with_attached_image

    food_to_delete = Food.find(params[:id])
    if food_to_delete.destroy
      flash.now[:success] = 'Food was successfully deleted.'
    else
      flash.now[:danger] = 'Food was not deleted because <ul class="error-list">'
      new_food.errors.full_messages.each do |msg|
        flash.now[:danger] += "<li>#{msg}</li>"
      end
      flash.now[:danger] += '</ul>'
    end
    render :index
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :image)
  end

  private :food_params
end
