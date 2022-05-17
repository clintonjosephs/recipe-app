class InventoryFoodsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    setup
  end

  def create
    setup
    inventory_food = InventoryFood.new(inventory_food_params)
    inventory_food.inventory_id = params[:inventory_id]
    if inventory_food.save
      flash[:success] = 'Food was successfully added to inventory.'
    else
      flash[:danger] = 'Food was not added to inventory because <ul class="error-list">'
      inventory_food.errors.full_messages.each do |msg|
        flash[:danger] += "<li>#{msg}</li>"
      end
      flash[:danger] += '</ul>'
    end
    redirect_to new_inventory_inventory_food_path(params[:inventory_id])
  end

  def setup
    @inventory_food = InventoryFood.new
    @inventory_food_ids = InventoryFood.all.where(inventory_id: params[:inventory_id]).pluck(:food_id)
    @foods = Food.all.where(user_id: current_user.id).where.not(id: @inventory_food_ids)
    @inventory = Inventory.find(params[:inventory_id])
  end

  def destroy
    inventory_food_to_delete = InventoryFood.find(params[:id])
    if inventory_food_to_delete.destroy
      flash[:success] = 'Food removed from inventory.'
    else
      flash[:danger] = 'Food could not be removed from inventory because <ul class="error-list">'
      inventory_food_to_delete.errors.full_messages.each do |msg|
        flash[:danger] += "<li>#{msg}</li>"
      end
      flash[:danger] += '</ul>'
    end
    redirect_to inventory_path(params[:inventory_id])
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:food_id, :quantity)
  end
end
