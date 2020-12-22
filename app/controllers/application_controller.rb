class ApplicationController < ActionController::Base
  include SessionsHelper

private


def authenticate

    authenticate_or_request_with_http_token do |token,options|
    auth_user = User.find_by(token: token)
    auth_user != nil ? true : false
  end
end






  #ログインしてなかったらログインページへ飛ばす
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください！"      
       respond_to do |format|
         format.html { redirect_to login_url }
         format.json { render plain:"だめです" }
       end
    
    end
  end


end
