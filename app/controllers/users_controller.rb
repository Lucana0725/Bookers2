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
    # 他人がユーザー情報を勝手に編集できないよう、アクセスさせなくする記述
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if (user_id != login_user_id)
      redirect_to user_path(current_user.id)
    end
    
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
