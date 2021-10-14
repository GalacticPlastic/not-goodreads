# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  rescue_from ActiveRecord::RecordNotUnique do
    error_info = {
      "errors": ['Limited one review per book.']
    }

    render json: error_info.to_json, status: 422
  end
end
