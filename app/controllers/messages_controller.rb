class MessagesController < ApplicationController
  include MessagesHelper
  before_action :logged_in_user
  before_action :message_authority, only: [:box]
  def create
    @user = User.find(params[:user_id])
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
      render 'error'

    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
  end

  def box
    @user = User.find(params[:id])

    # 自分が所属するルーム毎の最新メッセージ,作成日時と、メッセージ相手のid,名前,avatarのurlを取得する
    @new_send_messages = ActiveRecord::Base.connection.select_all("
      SELECT m3.room_id,content, partner_user_id, checked,
             partner_user_name, partner_users_avatar,m3.created_at
      FROM (
        SELECT m1.room_id AS room_id,
        m1.content AS content,
        m1.checked AS checked,
        m1.created_at AS created_at,
        users.id AS partner_user_id,
        users.name AS partner_user_name,
        users.avatar AS partner_users_avatar
        FROM messages m1
        JOIN entries ON entries.room_id = m1.room_id and entries.user_id != #{@user.id}
        JOIN users ON entries.user_id = users.id
      ) AS m3
      JOIN (SELECT room_id,MAX(created_at) AS created_at
      FROM messages
      WHERE room_id
      IN (SELECT entries.room_id FROM entries WHERE entries.user_id = #{@user.id})
      GROUP BY room_id) AS m2
      ON m3.room_id = m2.room_id AND m3.created_at = m2.created_at
      ").to_hash
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
