json.array!(@swap_requests) do |swap_request|
  json.extract! swap_request, :headcook_required, :message, :date, :isResolved?
  json.url swap_request_url(swap_request, format: :json)
end
