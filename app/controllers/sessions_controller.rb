class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:notice] = 'すでにログインしています'
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = 'ログインに成功しました！'
      redirect_back_or(@user)
    else
      flash.now[:danger] = 'メールアドレスとパスワードが一致しません'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
