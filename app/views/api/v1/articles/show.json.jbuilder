json.id @article.id
json.title @article.title
json.content @article.content.body.to_s
json.thumbnail @article.thumbnail
json.user_id @article.user.id
json.user_name @article.user.name
json.user_avatar @article.user.avatar
json.profile @article.user.profile
json.tag_list @article.tags do |tag|
  json.id tag.id
  json.name tag.name
  json.count tag.count
end

json.comments @comments do |comment|
  json.id comment.id
  json.content comment.content
  json.user_id comment.user.id
  json.user_name comment.user.name
  json.user_avatar comment.user.avatar
end
