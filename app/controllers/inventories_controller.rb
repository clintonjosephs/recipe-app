class InventoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @inventories = Inventory.all.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @inventory = Inventory.new
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
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
