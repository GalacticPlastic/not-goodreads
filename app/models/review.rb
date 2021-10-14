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
end
