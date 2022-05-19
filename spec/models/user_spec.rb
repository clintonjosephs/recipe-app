require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Validation for user model' do
        it 'should be valid with valid attributes' do
            user = User.new(
                email: 'test@mail.com',
                password: '12345678',
                password_confirmation: '12345678'
            )
            expect(user).to be_valid
        end
        
    end
end