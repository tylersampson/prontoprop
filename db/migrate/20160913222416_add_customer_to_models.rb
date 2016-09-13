class AddCustomerToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :customer, :string
    add_column :agents, :customer, :string
    add_column :attorneys, :customer, :string
    add_column :originators, :customer, :string
    add_column :banks, :customer, :string
    add_column :deductables, :customer, :string
    add_column :sales, :customer, :string
    add_column :leases, :customer, :string
    add_column :rentals, :customer, :string
  end
end
