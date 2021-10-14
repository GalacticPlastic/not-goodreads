# frozen_string_literal: true

module API
  class ReviewsController < ApplicationController
    def create; end

    def index
      render json: Review.all
    end

    def show
      render json: Review.find(params[:id])
    end

    def update; end

    private

    def allowed_params
      params.permit
    end
  end
end
