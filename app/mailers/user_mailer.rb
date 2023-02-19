# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome(user)
    mail(to: user.email, subject: 'Welcome!') do |format|
      format.html { render 'user_mailer/welcome', locals: { email: user.email } }
    end
  end
end
