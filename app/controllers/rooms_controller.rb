class RoomsController < ApplicationController
  
  def create
    # もし、指定した2人のルームがないなら作成
    @user = User.find_by(id:params[:entry][:user_id])

      unless Entry.find_by(user_id:@user.id).present? && Entry.find_by(user_id:current_user.id).present?  
       
        @room = Room.new
      
       if @room.save       
        @entry_user = Entry.create(room_id:@room.id, user_id:@user.id)
        @entry_current = Entry.create(room_id:@room.id, user_id:current_user.id)
        redirect_to room_url(@room,user_id:@user.id)
       end


      else
        flash[:danger]="無効な操作です"
        redirect_to user_url(@user)
      end
  end

  def show
    
    
    @user = User.find(params[:user_id])
    
    @room = Room.find_by_sql("SELECT * FROM rooms WHERE id =  
      (SELECT room_id FROM entries WHERE user_id = #{@user.id} && #{current_user.id})") 
    @message = Message.new    
    @messages = Message.where("room_id = #{@room[0].id}")
    
    


  end

end
