# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'success' do
    it 'should belongs to user' do
      should belong_to(:user)
    end

    it 'should validate the presence' do
      should validate_presence_of(:body)
    end

    it 'should validate the length of the body' do
      should validate_length_of(:body).is_at_most(280)
    end
  end

  describe 'failure' do
    let(:user) { create(:user) }

    it 'when more then 280 caracteres' do
      t = Tweet.new
      t.user = User.new
    end
  end
end
