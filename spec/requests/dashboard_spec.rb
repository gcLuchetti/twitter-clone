# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  describe 'GET /dashboard' do
    describe 'success' do
      context 'when not logged in' do
        subject(:get_dashboard) { get(dashboard_path) }

        it 'redirect to the sign in page' do
          get_dashboard
          expect(response).to have_http_status(:redirect)
            .and redirect_to(new_user_session_url)
        end
      end

      context 'when logged in' do
        let(:user_confirmed) { create(:user, :confirme_user) }

        subject(:get_dashboard) { get(dashboard_path) }

        before do
          sign_in(user_confirmed)
        end

        it 'access the page' do
          user_confirmed
          get_dashboard
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
