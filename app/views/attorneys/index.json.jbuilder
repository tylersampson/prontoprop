json.array!(@attorneys) do |attorney|
  json.extract! attorney, :id, :name, :telephone, :email, :preferred
  json.url attorney_url(attorney, format: :json)
end
