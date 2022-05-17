class FoodsController < ApplicationController
  
  def index
    @foods = Food.all.order(created_at: :desc).with_attached_image
  end

  def new
    @food = Food.new
    @measurement_units = units
  end

  def create
    @measurment_units = units
    new_food = Food.new()
    new_food.name = food_params[:name]
    new_food.price = food_params[:price]
    new_food.measurement_unit = "#{food_params[:measurment]} #{food_params[:m_unit]}"
    new_food.image = food_params[:image]
    new_food.user_id = current_user.id

    if new_food.save
      flash.now[:success] = 'Food was successfully created.'
      render :new
    else
      flash.now[:danger] = 'Food was not created because <ul class="error-list">'
      new_food.errors.full_messages.each do |msg|
        flash.now[:danger] += "<li>#{msg}</li>"
      end
      flash.now[:danger] += '</ul>'
      render :new
    end
  end

  def units
   [['grams', 'g'], ['kilograms', 'kg'], ['milligrams', 'ml'], ['liter', 'l'], ['ounces', 'oz'], ['pound', 'lb'], ['cup', 'cup'], ['pint', 'pint'], ['quart', 'quart'], ['gallon', 'gallon']]
  end

  def food_params
    params.require(:food).permit(:name, :measurment, :m_unit, :price, :image)
  end

  private :food_params, :units
end
