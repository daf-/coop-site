json.array!(@coops) do |coop|
  json.extract! coop, :name
  json.url coop_url(coop, format: :json)
end
