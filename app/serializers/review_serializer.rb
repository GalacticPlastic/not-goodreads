# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :description

  has_one :book
  has_one :user
end
