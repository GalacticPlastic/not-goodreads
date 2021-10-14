# frozen_string_literal: true

module API
  class ReviewsController < ApplicationController
    def create
      review = Review.new(allowed_params)

      if review.save
        render json: review
      else
        render json: { errors: review.errors.full_messages }
      end
    end

    def index
      render json: Review.all
    end

    def show
      render json: Review.find(params[:id])
    end

    def update; end

    private

    def allowed_params
      params.permit(:user_id, :book_id, :rating, :description)
    end
  end
end
