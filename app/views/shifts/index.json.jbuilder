json.array!(@shifts) do |shift|
  json.extract! shift, :coop_id, :start_time, :end_time, :activity, :leader
  json.url shift_url(shift, format: :json)
end
