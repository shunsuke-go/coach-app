json.id @user.id
json.name @user.name
json.ave_rate @user.ave_rate
json.user_avatar @user.avatar
json.profile @profile
json.liked_articles @user.liked_articles

json.articles @feed_items do |article|
  json.id article.id
  json.title article.title
  json.content article.content.body.to_s
  json.thumbnail article.thumbnail
  json.user_avatar article.user.avatar
  json.user_id article.user.id
  json.user_name article.user.name
  json.likes_count article.likes.count

  json.tag_list article.tags do |tag|
    json.id tag.id
    json.name tag.name
    json.count tag.taggings_count
  end
end
json.follower_count @user.followers.count
json.followed_count @user.following.count
