class UsersController < ApplicationController
before_action :logged_in_user, only:[:edit,:update]
before_action :correct_user, only:[:edit,:update]
before_action :check_admin, only:[:destroy]
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(session[:user_id])
  end



  def create
    @user = User.new(user_params)
    if @user.save
      log_in (@user)
      redirect_to root_url
    else
      render 'new'

    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新に成功しました！"
      redirect_to user_url(@user)

    else
      flash[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end
  

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "削除に成功しました"
    redirect_to user_url
  end
  
  


  private
  
  #Strong Parameter
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #ログインしてなかったらログインページへ飛ばす
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください！"
      redirect_to login_url
    end
  end

  #別のユーザーページを編集するのを防ぐ
  def correct_user
    @user = User.find_by(id: params[:id])
       if @user.nil?
        flash[:danger] = "無効な操作です"
       end 
    redirect_to root_url unless current_user?(@user)
  end

  #管理者かどうか確認
  def check_admin
    unless current_user.admin?
      falsh[:danger] = "管理者のみ行える操作です"
      redirect_to root_url
    end
  end


end
