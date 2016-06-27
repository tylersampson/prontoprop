json.array!(@agents) do |agent|
  json.extract! agent, :id, :first_name, :last_name, :employee_number, :mobile, :email, :tax_percent
  json.url agent_url(agent, format: :json)
end
