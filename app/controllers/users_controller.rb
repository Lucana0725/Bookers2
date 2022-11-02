class UsersController < ApplicationController
  def index
    @users = User.all
    # 部分テンプレート_infoのuserにわたす@userを定義。
    # indexページは、一覧を表示するだけであり、その一覧を見るユーザーはログインしているユーザーであることからcurrent_user
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    
    @book = Book.new
  end

  def edit
  end
end
