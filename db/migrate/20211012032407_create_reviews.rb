# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :rating, null: false
      t.timestamps

      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
    end
  end
end
