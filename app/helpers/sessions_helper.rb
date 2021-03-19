module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

    # ログイン中のユーザかどうかを判定する
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id] || cookies[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user

      end
    end
  end

    # ユーザのセッションを永続的にする
    # cookieの中に値を入れていく
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

    # ログインしているか判定する
  def logged_in?
    !current_user.nil?
  end

    # クッキーを削除する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

    # ログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

    # ログイン中のユーザーとアクセスするユーザーが正しいか確認する
  def current_user?(user)
    user && user == current_user
  end

      # 保存したURLか、それがなければ指定したURLにリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

      # GETリクエストだった場合、そのURLを保存する
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
