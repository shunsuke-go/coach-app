json.comments @comments do |comment|
  json.id comment.id
  json.content comment.content
  json.user_id comment.user.id
  json.user_name comment.user.name
  json.user_avatar comment.user.avatar
end
