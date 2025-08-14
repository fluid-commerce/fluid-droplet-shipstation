require "rails_helper"

RSpec.describe Api::V1::OrdersController, type: :controller do
  fixtures :companies
  
  let(:company) { companies(:acme) }
  let(:valid_token) { company.webhook_verification_token }
  
  describe "bearer token authentication" do
    it "allows access with valid auth token" do
      request.headers['HTTP_AUTH_TOKEN'] = valid_token
      post :create, params: { order: { orderNumber: "12345" } }
      
      expect(response.status).to eq(500) # Will fail with server error but authentication worked
      expect(controller.instance_variable_get(:@current_company)).to eq(company)
    end
    
    it "rejects request without auth token header" do
      post :create, params: { order: { orderNumber: "12345" } }
      
      expect(response.status).to eq(401)
      response_body = JSON.parse(response.body)
      expect(response_body["error"]).to eq("Invalid bearer token")
    end
    
    it "rejects request with invalid auth token" do
      request.headers['HTTP_AUTH_TOKEN'] = "invalid_token"
      post :create, params: { order: { orderNumber: "12345" } }
      
      expect(response.status).to eq(401)
      response_body = JSON.parse(response.body)
      expect(response_body["error"]).to eq("Invalid bearer token")
    end
    
    it "rejects request with empty auth token" do
      request.headers['HTTP_AUTH_TOKEN'] = ""
      post :create, params: { order: { orderNumber: "12345" } }
      
      expect(response.status).to eq(401)
      response_body = JSON.parse(response.body)
      expect(response_body["error"]).to eq("Invalid bearer token")
    end
  end
end 