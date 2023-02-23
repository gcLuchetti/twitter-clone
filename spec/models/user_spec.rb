# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'success' do
    let(:user1) { create(:user) }

    it 'should have many tweet' do
      should have_many(:tweets).dependent(:destroy)
    end

    it 'should be unique username' do
      user1
      should validate_uniqueness_of(:username).case_insensitive.allow_blank
    end

    it 'is valid' do
      expect(user1).to be_valid
    end

    it 'should send an welcome email' do
      expect { user1 }.to change { UserMailer.deliveries.count }.by(1)
    end
  end

  describe 'failure' do
    let(:userInvalidEmail) { create(:user, email: 'joe@gmail.com') }
    let(:userInvalidUsername) { create(:user, username: 'test-without-variation') }
    let(:userSmallPassword) { create(:user, password: 123) }
    let(:userWithoutPassword) { create(:user, password: nil) }
    let(:userWithoutEmail) { create(:user, email: nil) }
    let(:userunconfirmed) { create(:user) }

    it 'has a unique email' do
      create(:user, email: 'joe@gmail.com')
      expect { userInvalidEmail }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'has a unique username' do
      create(:user, username: 'test-without-variation')
      expect { userInvalidUsername }.to raise_error(ActiveRecord::RecordInvalid)
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
  end
end
