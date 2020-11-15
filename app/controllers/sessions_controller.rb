class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)

      #チェックボックスがONなら
      #remember_tokenをブラウザのクッキーに設定し、
      #remember_digestをDBに保存
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success]="ログインに成功しました！"
      redirect_to @user

      
    else
      flash.now[:danger] = 'メールアドレスとパスワードが一致しません'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success]="ログアウトしました"
    redirect_to root_url
  end

end
