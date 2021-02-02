class ApplicationController < ActionController::Base
  include SessionsHelper

  private

    def authenticate
      authenticate_or_request_with_http_token do |token, _options|
        auth_user = User.find_by(token: token)
        !auth_user.nil? ? true : false
      end
    end

    def logged_in_user
      return if logged_in?

      store_location
      flash[:danger] = 'ログインしてください！'
      redirect_to login_url
    end
end
