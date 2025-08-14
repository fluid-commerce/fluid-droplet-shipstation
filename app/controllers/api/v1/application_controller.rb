# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::Base
      # Skip CSRF token validation for API requests
      skip_before_action :verify_authenticity_token

      before_action :authenticate_bearer_token

      private

      def authenticate_bearer_token
        request_auth_token = request.headers['HTTP_AUTH_TOKEN'].to_s

        @current_company = Company.find_by(webhook_verification_token: request_auth_token)

        return if @current_company

        render json: { success: false, error: 'Invalid bearer token' }, status: :unauthorized
        nil
      end
    end
  end
end
