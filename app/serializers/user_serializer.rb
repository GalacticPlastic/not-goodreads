# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  # has_many :reviews
end
