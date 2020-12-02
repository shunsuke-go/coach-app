class MessagesController < ApplicationController

  def create
    @user = User.find_by(id:params[:user_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = params[:room_id]
    
    

    if @message.save
      @room = @message.room
      @message.create_message_notification(@user)
      
      
      flash[:success] = "メッセージを送信しました"
      respond_to do |format|
        format.html { redirect_to room_url(@room) }
        format.js
      end

      
    else
      flash[:danger] = "無効な操作です"
      redirect_to root_url
       
    end  

  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
