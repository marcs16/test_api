require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "Books API" do
    it "Returns all books" do
      FactoryBot.create_list(:book, 3)
      get '/api/v1/books'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['message']).to eq('Books list')
      expect(JSON.parse(response.body)['Books'].length).to eq(3)
      end
  end
end