json.array!(@statuses) do |status|
  json.extract! status, :id, :name, :nature, :can_edit
  json.url status_url(status, format: :json)
end
