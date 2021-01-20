json.array!(@reviews) do |review|
  json.content review.content
  json.id review.id
  json.rate review.rate
  json.rate_floor review.rate.floor
  json.user do
    json.name review.reviewer.name
    json.coach review.reviewer.coach?
    json.id review.reviewer.id
    json.avatar review.reviewer.avatar.url
  end
end
