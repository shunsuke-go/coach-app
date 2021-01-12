module MessagesHelper
  def non_duplicate_rooms(messages)
    rooms = []
    messages.each do |message|
      rooms.push(message.room.id)
    end
    rooms.uniq!
  end

  def non_duplicate_users(messages)
    users = []
    messages.each do |message|
      users.push(message.user.id)
    end
    users.uniq!
  end


end
