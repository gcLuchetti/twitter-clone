# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /index' do
    describe 'success' do
      subject(:get_home) { get(root_path) }

      it 'access the page' do
        get_home
        expect(response).to have_http_status(:success)
      end
    end
  end
end
