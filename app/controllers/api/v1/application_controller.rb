module Api
  module V1
    class ApplicationController < ActionController::Base
      # Skip CSRF token validation for API requests
      skip_before_action :verify_authenticity_token
      
      before_action :authenticate_bearer_token
      
      private

      def authenticate_bearer_token
        # request_auth_token = request.headers['HTTP_AUTH_TOKEN'].to_s
        request_auth_token = 'wvt_2Qtg3fBeaGBlNgK4lom8VoDqgv8orB6jo'

        @current_company = Company.find_by(webhook_verification_token: request_auth_token)
        
        unless @current_company
          render json: { success: false, error: 'Invalid bearer token' }, status: :unauthorized
          return
        end
      end
      # def render_error(message, status = :unprocessable_entity)
      #   render json: { success: false, error: message }, status: status
      # end
      
      # def render_unauthorized(message = 'Unauthorized')
      #   render json: { success: false, error: message }, status: :unauthorized
      # end
      
      # def render_forbidden(message = 'Forbidden')
      #   render json: { success: false, error: message }, status: :forbidden
      # end
      
      # def render_not_found(message = 'Not found')
      #   render json: { success: false, error: message }, status: :not_found
      # end
      
      # def render_bad_request(message = 'Bad request')
      #   render json: { success: false, error: message }, status: :bad_request
      # end
    end
  end
end 