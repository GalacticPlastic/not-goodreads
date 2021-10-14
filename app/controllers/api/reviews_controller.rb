# frozen_string_literal: true

module API
  class ReviewsController < ApplicationController
    def index
      @reviews = Review.all
      @reviews = Review.sort_by_lowest_rating if params[:sort_rating] == 'ASC'
      @reviews = Review.sort_by_highest_rating if params[:sort_rating] == 'DESC'
      @reviews = Review.has_description if params[:sort_description] == 'true'
      render json: @reviews
    end

    def show
      render json: Review.find(params[:id])
    end

    def create
      review = Review.new(allowed_params)

      if review.save
        render json: review
      else
        render json: { errors: review.errors.full_messages }
      end
    end

    def update
      review = Review.find(params[:id])

      if review.update(allowed_params)
        render json: review
      else
        render json: { errors: review.errors.full_messages }
      end
    end

    private

    def allowed_params
      params.permit(:rating, :description, :user_id, :book_id)
    end
  end
end
