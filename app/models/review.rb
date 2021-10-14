# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  after_create :update_average_book_rating

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

  validate :what_the_frak

  scope :has_description, -> { where.not(description: nil) }
  scope :sort_by_highest_rating, -> { order(rating: :desc) }
  scope :sort_by_lowest_rating, -> { order(rating: :asc) }

  private

  def update_average_book_rating
    book = Book.find_by!(id: Review.last.book_id)
    new_average = Review.where(book_id: book.id).average(:rating)

    book.update!(rating: new_average)
  end

  def what_the_frak
    submission = description.split
    profanity = %w[frak storms gorram nerfherder crivens]

    # TODO: Regex fanciness
    errors.add(:description, 'profanity not allowed!') unless (submission & profanity).empty?
  end
end
