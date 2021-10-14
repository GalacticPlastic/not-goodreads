# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reviews

  validates :first_name, :last_name, presence: true
end
