class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.paginate(page: params[:page], per_page: 10)
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    flash[:success] = '通知を全て削除しました！'
    redirect_to notifications_path
  end
end
