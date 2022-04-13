require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "Books API" do
    describe "GET /api/v1/books" do
      it "Returns all books" do
        FactoryBot.create_list(:book, 3)
        get '/api/v1/books'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Books list')
        expect(JSON.parse(response.body)['Books'].length).to eq(3)
      end

    end

    describe "POST /api/v1/books" do
      it "Creates a new book" do
        book_params = FactoryBot.attributes_for(:book)
        expect {
        post '/api/v1/books', params: 
                              { book: { title: book_params[:title], 
                                author: book_params[:author], 
                                published_at: book_params[:published_at] } }
                                .to_json, headers: { 'Content-Type' => 'application/json' } 
        }.to change(Book, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Book successfully created')
      end

      it "Returns an error if the book is invalid" do
        book_params = FactoryBot.attributes_for(:book)
        expect {
        post '/api/v1/books', params: 
                              { book: { title: book_params[:title],
                               author: book_params[:author]}}
                                .to_json, headers: { 'Content-Type' => 'application/json' }
        }.to change(Book, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to eq("published_at" => ["can't be blank", "is not a number"])
      end
    end

    describe "DELETE /api/v1/books/:id" do
      let!(:book) {FactoryBot.create(:book)}
      it "Deletes a book" do
        expect {
          delete "/api/v1/books/#{book.id}"
        }.to change(Book, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end

      it "Returns an error if the book is not found" do
        delete "/api/v1/books/0"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']).to eq("Couldn't find Book with 'id'=0")
      end
    end


  end
end