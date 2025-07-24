# frozen_string_literal: true

module Api
  module V1
    class OrdersController < Api::V1::ApplicationController
      def create
        create_order_service = Shipstation::CreateOrder.new(params, @current_company.id)
        result = create_order_service.call

        if result.success?
          render json: { success: true, data: result.data }, status: :created
        else
          render json: { success: false, error: result.error }, status: :unprocessable_entity
        end
      rescue StandardError => e
        Rails.logger.error("Error creating order: #{e.message}")
        render json: { success: false, error: 'Internal server error' }, status: :internal_server_error
      end
    end
  end
end
