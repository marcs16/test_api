class Api::V1::BooksController < ApplicationController
  def index
    
    books = Book.page(page_format(params)).per(per_page_format(params))
    render json: books,  meta:{message: "Books list"}, status: :ok
  end

  def create
    author = Author.create!(author_params)
    book = Book.new(book_params.merge(author_id: author.id))
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
    params.require(:book).permit(:title, :published_at)
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name, :age)
  end

  def page_format(params, default = 1)
    params[:page].present? ? params[:page][:number].to_i : default
  end

  def per_page_format(params, default = Book.default_per_page)
    params[:page].present? ? params[:page][:size].to_i : default
  end
end
