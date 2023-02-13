# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'success' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user, :confirm_user) }

    it 'should have many tweet' do
      should have_many(:tweets).dependent(:destroy)
    end

    it 'is valid and confirmed - without trait' do
      expect(user1).to be_valid
      user1.confirm
      expect(user1).to be_confirmed
      expect(user1).to have_attributes(confirmed_at: (be_within(1.second).of Time.now))
    end

    it 'is valid and confirmed - with trait' do
      expect(user2).to be_valid.and be_confirmed
      expect(user2).to have_attributes(confirmed_at: (be_within(1.second).of Time.now))
    end
  end

  describe 'failure' do
    let(:userInvalidEmail) { create(:user, email: 'joe@gmail.com') }
    let(:userSmallPassword) { create(:user, password: 123) }
    let(:userWithoutPassword) { create(:user, password: nil) }
    let(:userWithoutEmail) { create(:user, email: nil) }
    let(:userunconfirmed) { create(:user) }

    it 'has a unique email' do
      expect { userInvalidEmail }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is not valid with a password smaller then 6 characters' do
      expect { userSmallPassword }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is not valid without a password' do
      expect { userWithoutPassword }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is not valid without an email' do
      expect { userWithoutEmail }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is not confirmed' do
      expect(userunconfirmed).to_not be(userunconfirmed.confirmed?)
      expect(userunconfirmed).to have_attributes(confirmed_at: nil)
    end
  end
end
