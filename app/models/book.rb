# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author
  has_many :reviews, -> { distinct }, through: :users

  validates :title, :description, presence: true
end
