# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating,
            inclusion: { in: 1..5, message: 'Rating is not within the permitted range of 1 to 5.' }
  validates_uniqueness_of :id, scope: %i[user_id book_id]
end
