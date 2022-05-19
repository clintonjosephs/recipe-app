require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Validation for inventory model' do
    before(:each) do
      @user = User.create(
        email: 'test@mail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )

      @inventory = Inventory.new(
        name: 'Inventory',
        description: 'Inventory',
        user_id: @user.id
      )
    end

    before { @inventory.save }

    it 'should be valid with valid attributes' do
      @inventory.id = 1
      @inventory.name = 'Inventory'
      @inventory.description = 'Inventory'
      @inventory.user_id = @user.id
      expect(@inventory).to be_valid
    end

    it 'should not be valid without name' do
      @inventory.name = nil
      @inventory.description = 'Inventory'
      expect(@inventory).to_not be_valid
    end

    it 'should not be valid without user_id' do
      @inventory.user_id = nil
      expect(@inventory).to_not be_valid
    end
  end
end
