class InventoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @inventories = Inventory.all.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @inventory = Inventory.new
  end

  def show
    @inventory = Inventory.find(params[:id])
    @inventory_foods = Food.all.joins('INNER JOIN inventory_foods ON foods.id = inventory_foods.food_id')
      .order(created_at: :desc).select('foods.*, inventory_foods.quantity, inventory_foods.id as inventory_food_id')
      .where(inventory_foods: { inventory_id: params[:id] }).with_attached_image
  end

  def create
    inventory = Inventory.new(inventory_params)
    inventory.user_id = current_user.id
    if inventory.save
      flash.now[:success] = 'Inventory was successfully created.'
      redirect_to inventories_path
    else
      flash.now[:danger] = 'Inventory was not created because <ul class="error-list">'
      inventory.errors.full_messages.each do |msg|
        flash.now[:danger] += "<li>#{msg}</li>"
      end
      flash.now[:danger] += '</ul>'
      render :new
    end
  end

  def destroy
    @inventories = Inventory.all.where(user_id: current_user.id).order(created_at: :desc)
    inventory_to_delete = Inventory.find(params[:id])
    if inventory_to_delete.destroy
      flash.now[:success] = 'Inventory was successfully deleted.'
    else
      flash.now[:danger] = 'Inventory was not deleted because <ul class="error-list">'
      new_food.errors.full_messages.each do |msg|
        flash.now[:danger] += "<li>#{msg}</li>"
      end
      flash.now[:danger] += '</ul>'
    end
    render :index
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
