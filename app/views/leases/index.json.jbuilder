json.array!(@leases) do |lease|
  json.extract! lease, :id, :reference, :payprop_reference, :rent_amount, :managed, :start_on, :end_on, :deposit_amount, :deposit_held_by, :lessor_id, :lessee_id, :lease_fee, :inspection_fee, :credit_check_fee, :credit_check_on, :deposit_released_on, :deposit_released_to
  json.url lease_url(lease, format: :json)
end
