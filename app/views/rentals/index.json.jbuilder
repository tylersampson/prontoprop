json.array!(@rentals) do |rental|
  json.extract! rental, :id, :lease_id, :received_on, :amount_received, :commission_amount, :tax_amount, :fees_amount
  json.url rental_url(rental, format: :json)
end
