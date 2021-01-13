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

  def get_new_messages(messages)
    new_messages = []
    message_box = nil
    messages.each_with_index do |message, index|
      if index == 0
        message_box = message
      end

      if message_box.room.id != message.room.id
        new_messages.push(messages[index - 1])
        message_box = message
      end
      if messages[messages.length - 1] == messages[index]
        new_messages.push(message)
      end
    end

    new_messages
  end
end
