# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :rating, :description, :user_id, :book_id

  attribute :user_id do
    object.user.id
  end

  attribute :book_id do
    object.book.id
  end
end
