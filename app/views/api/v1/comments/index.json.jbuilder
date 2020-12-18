json.array!(@comments) do |comment|
  json.content comment.content
  json.id comment.id
  json.user do
    json.name  comment.user.name
    json.id comment.user.id
  end
end