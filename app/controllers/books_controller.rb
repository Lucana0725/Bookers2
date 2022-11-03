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
    # 部分テンプレート_infoのuserにわたす@userを定義。
    # indexページは、一覧を表示するだけであり、その一覧を見るユーザーはログインしているユーザーであることからcurrent_user
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    # 部分テンプレート_infoのuserにわたす@userを定義。
    # books#showは単一のbookをみるページであり、bookについているユーザーの情報を持ってくる必要があるので、
    # @book.user。(userとモデルを指定しているのは、@bookのidに紐づいている「全ての」ユーザー情報が欲しいため。)
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(params[:id])
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
