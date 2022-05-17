class InventoryFoodsController < ApplicationController
    load_and_authorize_resource
    before_action :authenticate_user!

    def new
        @inventory_food = InventoryFood.new
        @foods = Food.all.where(user_id: current_user.id).order(name: :asc)
    end
end