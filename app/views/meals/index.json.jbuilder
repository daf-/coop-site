json.array!(@meals) do |meal|
  json.extract! meal, :type, :isSpecial, :name
  json.url meal_url(meal, format: :json)
end
