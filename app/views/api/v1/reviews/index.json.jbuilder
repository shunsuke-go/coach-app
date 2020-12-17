json.array!(@reviews) do |review|
  json.content review.content
  json.id review.id
  json.rate review.rate
  json.user do
    json.name review.reviewer.name
    json.id review.reviewer.id
  end
end
