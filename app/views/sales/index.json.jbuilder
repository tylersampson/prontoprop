json.array!(@sales) do |sale|
  json.extract! sale, :id, :reference, :seller_id, :buyer_id, :contract_start_on, :purchase_price, :deposit_amount, :deposit_due_on, :attorney_id, :bond_attorney_id, :bond_due_on, :originator_id, :status_id, :registered_on, :bank_id, :grant_amount, :commission_amount, :tax_amount
  json.url sale_url(sale, format: :json)
end
