# frozen_string_literal: true

class AuthorSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :description, :genres, :website
  # has_many :reviews
end
