json.articles @articles do |article|
  json.id article.id
  json.title article.title
  json.content article.content.body
  json.thumbnail article.thumbnail
  json.user_id article.user.id
  json.user_name article.user.name
  json.user_avatar article.user.avatar
  json.tag_list article.tags do |tag|
    json.id tag.id
    json.name tag.name
    json.count tag.count  
  end
end
  
json.tags @tags do |tag|
    json.id tag.id
    json.name tag.name
    json.count tag.count
end

json.user_ranks @user_ranks do |user_rank|
  json.id user_rank.id
  json.name user_rank.name
  json.avatar user_rank.avatar
  json.ave_rate user_rank.ave_rate
end