# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating,
            inclusion: {
              in: 1..5,
              message: 'not within the permitted range of 1 to 5.'
            }
  validates :id,
            uniqueness: {
              case_sensitive: false,
              scope: %i[user_id book_id],
              message: 'limited to one review per book.'
            }

  scope :has_description, -> { where.not(description: nil) }
  scope :sort_by_highest_rating, -> { order(rating: :desc) }
  scope :sort_by_lowest_rating, -> { order(rating: :asc) }
end
