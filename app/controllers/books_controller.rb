class BooksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:update, :create, :destroy]
  
    def index
      @books = Book.all
      respond_to do |format|
        format.html
        format.json{ render json: @books}
      end
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            render json: @book
        else
            render json: @book.errors
        end
    end
  
    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors
      end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
    end
  
    private
  
    def book_params
      params.require(:book).permit(:genre, :title, :author, :price)
    end
  end
  