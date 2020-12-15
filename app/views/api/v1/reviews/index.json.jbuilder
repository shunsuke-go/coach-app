json.array!(@reviews) do |review|
  json.content review.content
  json.id review.id
  json.uesr do
    json.name review.reviewer.name
  end
end
