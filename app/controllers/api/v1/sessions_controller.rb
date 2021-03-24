module Api::V1
  class SessionsController < ApplicationController
    def create
      @user = User.find_by(email: params[:session][:user][:email].downcase)
      if @user && @user.authenticate(params[:session][:user][:password])
        log_in(@user)
        # params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        remember(@user)
        render json: {
          logged_in: true,
          user: @user,
          liked_articles: @user.liked_articles.with_rich_text_content.includes(
            :user, :liked_users, :likes, :comments, :taggings, :tags
          )
        }

      else
        render json: { status: 401, errors: '認証に失敗しました' }
      end
    end

    def logout
      if logged_in?
        log_out
      end
      render json: { message: 'ログアウトしました' }
    end

    def react_logged_in?
      if logged_in?
        render json: {
          logged_in: true,
          user: @current_user,
          liked_articles: @current_user.liked_articles.with_rich_text_content.includes(
            :user, :liked_users, :likes, :comments, :taggings, :tags
          )
        }
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
