json.array!(@comments) do |comment|
  json.content comment.content
  json.id comment.id
  json.article do
    json.id comment.article.id
  end
  json.user do
    json.name comment.user.name
    json.id comment.user.id
    json.token comment.user.token
  end
end
