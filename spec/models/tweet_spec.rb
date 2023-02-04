# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it 'should belongs to user' do
    should belong_to(:user)
  end

  describe 'failure' do
    let(:user) { create(:user) }

    it 'when more then 280 caracteres' do
      t = Tweet.new
      t.user = User.new
    end
  end
end
