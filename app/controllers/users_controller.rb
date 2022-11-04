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
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(params[:id])
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
