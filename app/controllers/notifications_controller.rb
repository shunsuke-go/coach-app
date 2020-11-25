class NotificationsController < ApplicationController
def index
  @notifications = current_user.passive_notifications
end


def destroy_all
  
  current_user.passive_notifications.destroy_all
  flash[:success] = "通知を全て削除しました！"
  redirect_to notifications_path

end



end
