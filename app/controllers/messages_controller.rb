class MessagesController < ApplicationController
  include MessagesHelper
  before_action :logged_in_user
  before_action :message_authority, only: [:from]
  def create
    @user = User.find_by(id: params[:user_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = params[:room_id]

    if @message.save
      @room = @message.room
      @message.create_message_notification(@user)

      flash[:success] = 'メッセージを送信しました'
      respond_to do |format|
        format.html { redirect_to room_url(@room) }
        format.js
      end

    else
      flash[:danger] = '無効な操作です'
      redirect_to root_url

    end
  end

  def from
    # 自分が所属するルームで自分以外のユーザが書いたメッセージが受信メッセージとなる。
    @user = User.find(params[:id])
    @receive_messages = Message.find_by_sql("
      SELECT * FROM messages WHERE room_id IN (
        SELECT room_id FROM entries WHERE user_id = #{@user.id}
      ) && user_id != #{@user.id}")
    @rooms = non_duplicate_rooms(@receive_messages)
    @users = non_duplicate_users(@receive_messages)
    @new_messages = get_new_messages(@receive_messages)
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end

    def message_authority
      @user = User.find(params[:id])
      if current_user.id != @user.id
        flash[:danger] = '不正な操作です'
        redirect_to root_path
      end
    end
end
