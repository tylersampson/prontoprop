class AddCompanyToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :company, :string
  end
end
