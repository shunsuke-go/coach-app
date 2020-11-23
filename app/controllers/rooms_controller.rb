class RoomsController < ApplicationController

  before_action :room_exists?,only:[:create]
  before_action :room_mached?,only:[:show]

  
  
  def create
    # もし、指定した2人のルームがないなら作成
    @user = User.find_by(id:params[:entry][:user_id])

      
        @room = Room.new
      
       if @room.save       
        @entry_user = Entry.create(room_id:@room.id, user_id:@user.id)
        @entry_current = Entry.create(room_id:@room.id, user_id:current_user.id)
        redirect_to room_url(@room,user_id:@user.id)
       

       else
      
        flash[:danger]="無効な操作です"
        redirect_to user_url(@user)
       end
  end
  

  def show
    # @userは配列
    @user = User.find_by_sql("SELECT * FROM users WHERE id = 
       (SELECT user_id FROM entries WHERE room_id = #{params[:id]} && user_id != #{current_user.id})")
    
    
    
    @room = Room.find_by(id: params[:id])
    @message = Message.new    
    @messages = Message.where("room_id = #{@room.id}")

    # select * from users where id = 
    # (select user_id from entries where room_id = #{params[:id] && user_id != #{current_user.id})
  end  
    private

      def room_exists? 
        
        
        check_room = Room.find_by_sql("select * from rooms where id in 
          (select room_id from entries where user_id = #{params[:entry][:user_id]} && 
          room_id in (select room_id from entries where user_id = #{current_user.id}))")

          unless check_room[0].nil?
            redirect_to room_url(check_room)
          end
      end


      def room_mached?
        # current_userとentryのuserが同じかどうか

        room = Room.find_by(id: params[:id])
        check_entry = Entry.where("room_id = #{room.id} && user_id = #{current_user.id}")

        if check_entry.empty?
          flash[:danger] = "不正な操作です。"
          redirect_to root_url
        end   
      end

          

      
          
      

end
