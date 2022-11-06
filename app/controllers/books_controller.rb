class BooksController < ApplicationController
  # New Book画面をusers#showに引っ越したので、@book = Book.newもusers_controller#showへ引っ越し。
  # def new
  #   @book = Book.new
  # end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    # 部分テンプレート_infoのuserにわたす@userを定義。
    # indexページは、一覧を表示するだけであり、その一覧を見るユーザーはログインしているユーザーであることからcurrent_user
    @user = current_user
  end

  def show
    @bookn = Book.new
    @book = Book.find(params[:id])
    # 部分テンプレート_infoのuserにわたす@userを定義。
    # books#showは単一のbookをみるページであり、bookについているユーザーの情報を持ってくる必要があるので、
    # @book.user。(userとモデルを指定しているのは、@bookのidに紐づいている「全ての」ユーザー情報が欲しいため。)
    @user = @book.user
  end

  def edit
    # 他人が投稿内容を勝手に編集できないよう、アクセスさせなくする記述
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if (user_id != login_user_id)
      redirect_to books_path
    end
    
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
