module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
    
    #ログイン中のユーザかどうかを判定する
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])      
      end   
    end

    #ログインしているか判定する
      def logged_in?
        !current_user.nil?
      end 

    #ログアウトする
      def log_out
        session.delete(:user_id)
        @current_user = nil
      end
  
    
end
