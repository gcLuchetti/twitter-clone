# frozen_string_literal: true

class UsernamesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_username_form

  def new; end

  def update
    username = username_params[:username]

    if username.present? && current_user.update(username:)
      redirect_to dashboard_path
    else
      flash[:alert] ||= username.blank? ? 'Please set a username' : current_user.errors.full_messages.join(', ')

      redirect_to new_username_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username).to_h
  end
end
