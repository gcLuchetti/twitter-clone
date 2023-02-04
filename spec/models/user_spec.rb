# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'success' do
    let(:user1) { create(:user) }

    it 'should have many tweet' do
      should have_many(:tweets).dependent(:destroy)
    end

    it 'is valid' do
      expect(user1).to be_valid
    end
  end

  describe 'failure' do
    let(:userInvalidEmail) { create(:user, email: 'joe@gmail.com') }
    let(:userSmallPassword) { create(:user, password: 123) }
    let(:userWithoutPassword) { create(:user, password: nil) }
    let(:userWithoutEmail) { create(:user, email: nil) }

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
  end
end
