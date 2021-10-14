class AddMissingNonNullConstraintsToReviews < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reviews, :user_id, false
    change_column_null :reviews, :book_id, false
    change_column_null :books, :author_id, false
    change_column_null :authors, :description, false
  end
end
