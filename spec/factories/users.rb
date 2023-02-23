# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 10) }  
    email { Faker::Internet.email }
    password { "blabla" }
  end
end
