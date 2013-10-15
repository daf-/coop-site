json.array!(@users) do |user|
  json.extract! user, :email, :username
  json.url user_url(user, format: :json)
end
