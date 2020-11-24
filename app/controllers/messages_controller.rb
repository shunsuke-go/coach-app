class MessagesController < ApplicationController

  def create
    @user = User.find_by(id:params[:user_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = params[:room_id]

    

    if @message.save
      @message.create_message_notification(@user)
      
      
      flash[:success] = "メッセージを送信しました"
      redirect_to room_url(params[:room_id],user_id: @user.id)
    else
      flash[:danger] = "無効な操作です"
      redirect_to room_url(params[:room_id])
       
    end  

  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
