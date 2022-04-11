class BooksController < ApplicationController
  def index
    render json: { message: 'Books list',Books: Book.all}, status: :ok
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
      render json: {message: "Book successfully deleted"}, head: :no_content
    else
      record_not_found(book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_at)
  end

end
