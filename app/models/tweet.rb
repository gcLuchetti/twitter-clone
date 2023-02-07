# frozen_string_literal: true

class Tweet < ApplicationRecord
  validates :body, presence: true, length: { minimum: 3, maximum: 280 }

  belongs_to :user
end
