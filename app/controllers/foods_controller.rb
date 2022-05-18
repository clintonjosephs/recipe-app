class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = Food.all.where(user_id: current_user.id).order(created_at: :desc).with_attached_image
  end

  def new
    @food = Food.new
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
