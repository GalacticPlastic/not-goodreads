# frozen_string_literal: true

class BookSerializer < ActiveModel::Serializer
  attributes :title, :description, :author_id

  attribute :author_id do
    object.author.id
  end
end
