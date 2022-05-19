require 'rails_helper'

RSpec.describe Food, type: :model do
    describe 'Validation for food model' do
        before(:each) do
            @user = User.create(
                email: 'test@mail.com',
                password: '12345678',
                password_confirmation: '12345678'
            )
            @food = Food.new(
                name: 'Food',
                measurement_unit: 'g',
                price: '10',
                user_id: @user.id
            )
        end

        before {@food.save}


        it 'should be valid with valid attributes' do
            @food.name = 'Food'
            @food.measurement_unit = 'g'
            @food.price = '10'
            @food.user_id = @user.id
            expect(@food).to be_valid
        end

       
    end
end