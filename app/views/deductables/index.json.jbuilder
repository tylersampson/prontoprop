json.array!(@deductables) do |deductable|
  json.extract! deductable, :id, :name, :default_cost
  json.url deductable_url(deductable, format: :json)
end
