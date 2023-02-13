# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "blabla" }
  end

  trait :confirme_user do
    after(:create) { |user| user.confirm }
  end
end
