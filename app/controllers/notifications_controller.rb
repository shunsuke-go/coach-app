class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    @notifications = current_user.passive_notifications
    .includes(:visiter, :visited, :article, :comment, :message)
    .paginate(page: params[:page], per_page: 10)

    @notifications.update(checked: true)
  end

  def destroy_all
    current_user.passive_notifications.destroy_all
    flash[:success] = '通知を全て削除しました！'
    redirect_to notifications_path
  end
end
