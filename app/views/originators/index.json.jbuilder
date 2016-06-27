json.array!(@originators) do |originator|
  json.extract! originator, :id, :name, :telephone, :email, :preferred
  json.url originator_url(originator, format: :json)
end
