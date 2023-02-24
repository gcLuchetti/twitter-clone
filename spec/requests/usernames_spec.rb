# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Usernames', type: :request do
  describe 'GET /usernames/new' do
    describe 'success' do
      context 'username is nil' do
        context 'when not logged in' do
          let(:user) { create(:user, username: nil) }

          subject(:get_dashboard) { get(dashboard_path) }

          it 'redirect to the sign in page and then redirects to set username' do
            get_dashboard

            expect(response).to have_http_status(:redirect)
              .and redirect_to(new_user_session_url)

            sign_in(user)
            follow_redirect!

            expect(response).to have_http_status(:redirect)
              .and redirect_to(dashboard_path)

            follow_redirect!

            expect(response).to have_http_status(:redirect)
              .and redirect_to(new_username_path)
          end
        end

        context 'when logged in' do
          let(:user) { create(:user, username: nil) }

          subject(:get_dashboard) { get(dashboard_path) }

          before do
            sign_in(user)
          end

          it 'access the page and then redirects to set the username' do
            user
            get_dashboard
            expect(response).to have_http_status(:redirect)
              .and redirect_to(new_username_path)
          end
        end
      end
    end
  end

  describe 'PUT /usernames/update' do
    describe 'success' do
      context 'update with valid username' do
        let(:user) { create(:user, username: nil) }
        let(:username) { Faker::Internet.username }
        let(:params) { { user: { username: } } }

        subject(:update_username) { put(username_path(user), params:) }

        before do
          sign_in(user)
        end

        it 'updates the username' do
          expect { update_username }.to change { user.reload.username }.from(nil).to(username)
          expect(response).to have_http_status(:redirect)
            .and redirect_to dashboard_path
        end
      end
    end

    describe 'failure' do
      context 'update with already taken username' do
        let(:username) { Faker::Internet.username }
        let(:user) { create(:user, username: nil) }
        let!(:another_user) { create(:user, username:) }
        let(:params) { { user: { username: } } }

        subject(:update_username) { put(username_path(user), params:) }

        before do
          sign_in(user)
        end

        it 'does not update the username' do
          expect { update_username }.not_to(change { user.reload.username })

          expect(response).to have_http_status(:redirect)
            .and redirect_to new_username_path

          expect(flash[:alert]).to be_present
        end
      end

      context 'update with empty username' do
        let(:username) { ['', nil].sample }
        let(:user) { create(:user, username: nil) }
        let(:params) { { user: { username: } } }

        subject(:update_username) { put(username_path(user), params:) }

        before do
          sign_in(user)
        end

        it 'does not update the username' do
          expect { update_username }.not_to(change { user.reload.username })

          expect(response).to have_http_status(:redirect)
            .and redirect_to new_username_path

          expect(request.flash[:alert]).to be_present
        end
      end
    end
  end

  describe '#after_sign_in_path_for' do
    context 'when there is a stored location' do
      # it 'returns the stored location' do
      # end
    end

    context 'when there is no stored location' do
      # it 'returns the dashboard path' do
      # end
    end
  end
end
