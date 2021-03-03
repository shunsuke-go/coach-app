module MessagesHelper
  def message_check
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
        JOIN entries ON entries.room_id = m1.room_id and entries.user_id != #{current_user.id}
        JOIN users ON entries.user_id = users.id
      ) AS m3
      JOIN (SELECT room_id,MAX(created_at) AS created_at
      FROM messages
      WHERE room_id
      IN (SELECT entries.room_id FROM entries WHERE entries.user_id = #{current_user.id})
      GROUP BY room_id) AS m2
      ON m3.room_id = m2.room_id AND m3.created_at = m2.created_at
      ").to_hash

    @new_send_messages.each do |new_send_message|
      if new_send_message['checked'] != true
        return 1
      end
    end
  end
end
