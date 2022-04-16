class Api::V1::BooksController < ApplicationController
  def index
    books = Book.all
    render json: books.only(:title, :published_at, :author_id),  meta:{message: "Books list"}, status: :ok
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: {message: "Book successfully created", Book: book}, status: :created
    else
     record_invalid(book)
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy!
      head :no_content
      
    else
      record_not_found(book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :published_at, :author_id)
  end

end
