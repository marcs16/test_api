require 'rails_helper'

RSpec.describe "Authentication", type: :request do

  describe "POST /api/v1/authenticate" do
    let(:user) { {email: "test@test", password: "12345678"} }
    context "with valid credentials" do
      it "Authenticates the user" do
          post "/api/v1/authenticate", params: { user:  user }
          expect(response).to have_http_status(:created)
          expect(response.body).to eq({ 
                                      "token" => "123"}.to_json)
      end

      it "Returns an error when email is missing" do
          post "/api/v1/authenticate", params: {user: {password: user[:password]}}
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to include(
                                                          "param is missing or the value is empty: email")
      end

      it "Returns an error when password is missing" do
          post "/api/v1/authenticate", params: {user: {email: user[:email]}}
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to include(
                                                          "param is missing or the value is empty: password")
      end

      it "returns and error when params are missing" do
          post "/api/v1/authenticate", params: {user: {}}
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to include(
          "param is missing or the value is empty: email, param is missing or the value is empty: password")
      end
    end               
  end
end