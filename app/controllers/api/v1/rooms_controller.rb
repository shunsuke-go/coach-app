module Api::V1
  class RoomsController < ApplicationController
    def create
      @user = User.find(params[:entry][:user_id])
      @current_user = User.find(params[:entry][:current_user_id])

      @room_check = @user.users_room(@current_user)

      unless @room_check[0].nil?
        redirect_to("#{ENV['BASE_URL']}/rooms/#{@room_check[0].id}") and return
      end

      @room = Room.new
      if @room.save
        @entry_user = Entry.create(room_id: @room.id, user_id: @user.id)
        @entry_current = Entry.create(room_id: @room.id, user_id: @current_user.id)
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
      render 'rooms/show', formats: :html
    end
  end
end
