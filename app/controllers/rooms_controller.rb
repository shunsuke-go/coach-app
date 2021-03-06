class RoomsController < ApplicationController
  before_action :room_exists?, only: [:create]
  before_action :room_mached?, only: [:show]
  before_action :logged_in_user, only: [:create, :show]

  def create
    @user = User.find_by(id: params[:entry][:user_id])

    @room_check = @user.users_room(@current_user)

    unless @room_check[0].nil?
      redirect_to controller: :rooms, action: :show, id: room_check[0].id
    end

    @room = Room.new
    if @room.save
      @entry_user = Entry.create(room_id: @room.id, user_id: @user.id)
      @entry_current = Entry.create(room_id: @room.id, user_id: current_user.id)
      redirect_to room_url(@room)
    else
      flash[:danger] = '無効な操作です'
      redirect_to user_url(@user)
    end
  end

  def show
    # @userは配列
    @user = User.find_by_sql("SELECT * FROM users WHERE id =
       (SELECT user_id FROM entries WHERE room_id = #{params[:id]} && user_id != #{current_user.id})")
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = Message.includes(:user).where("room_id = #{@room.id}")
    @messages.update(checked: true)
  end

  private

    def room_exists?
      check_room = Room.find_by_sql("SELECT * FROM rooms WHERE id IN
          (SELECT room_id FROM entries WHERE user_id = #{params[:entry][:user_id]} &&
          room_id IN (SELECT room_id FROM entries WHERE user_id = #{current_user.id}))")

      return if check_room[0].nil?

      redirect_to room_url(check_room)
    end

    def room_mached?
      # current_userとentryのuserが同じかどうか

      room = Room.find(params[:id])
      check_entry = Entry.where("room_id = #{room.id} && user_id = #{current_user.id}")

      if check_entry.empty?
        flash[:danger] = '不正な操作です。'
        redirect_to root_url
      end
    end
end
