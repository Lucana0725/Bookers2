class BooksController < ApplicationController
  # New Book画面をusers#showに引っ越したので、@book = Book.newもusers_controller#showへ引っ越し。
  # def new
  #   @book = Book.new
  # end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
  end
  
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
