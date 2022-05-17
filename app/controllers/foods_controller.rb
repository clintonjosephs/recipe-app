class FoodsController < ApplicationController
  def index; end

  def new
    @food = Food.new
    @measurement_units = [['grams', 'g'], ['kilograms', 'kg'], ['milligrams', 'ml'], ['liter', 'l'], ['ounces', 'oz'], ['pound', 'lb'], ['cup', 'cup'], ['pint', 'pint'], ['quart', 'quart'], ['gallon', 'gallon']]
  end
end
