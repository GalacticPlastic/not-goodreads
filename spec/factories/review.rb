# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(from: 1, to: 5) }
    description { Faker::ChuckNorris.fact }

    association :book, factory: :book
    association :user, factory: :user
  end
end
