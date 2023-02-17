# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST /create' do
    describe 'success' do
      context 'when not logged in' do
        let(:params) { { tweet: { body: 'blabla' } } }

        subject(:post_tweet) { post(tweets_path, params:) }

        it 'redirect to the sign in page' do
          post_tweet
          expect(response).to have_http_status(:redirect)
            .and redirect_to(new_user_session_url)
        end
      end

      context 'when logged in' do
        let(:params) { { tweet: { body: 'blabla' } } }
        let(:user_confirmed) { create(:user, :confirm_user) }

        subject(:post_tweet) { post(tweets_path, params:) }

        before do
          sign_in(user_confirmed)
        end

        it 'access the page' do
          user_confirmed
          post_tweet
          expect(response).to have_http_status(:redirect)
            .and redirect_to(dashboard_path)
        end
      end
    end
  end
end
