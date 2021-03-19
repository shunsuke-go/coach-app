module Api::V1
  class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:session][:user][:email].downcase)
      if @user && @user.authenticate(params[:session][:user][:password])
        log_in(@user)
        # params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        remember(@user)
        render json: { logged_in: true, user: @user }
      else
        render json: { status: 401, errors: '認証に失敗しました' }
      end
    end

    def destroy
      log_out if logged_in?
      render json: { message: 'ログアウトしました' }
    end

    def react_logged_in?
      if logged_in?
        render json: { logged_in: true, user: @current_user }
      else
        render json: { logged_in: false, message: 'ユーザが存在しません。' }
      end
    end

    private

      def session_params
        params.require(:user).permit(:email, :password)
      end
  end
end
