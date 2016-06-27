class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.string :reference
      t.references :seller, references: :contacts
      t.references :buyer, references: :contacts
      t.date :contract_start_on
      t.decimal :purchase_price, precision: 14, scale: 2
      t.decimal :deposit_amount, precision: 14, scale: 2
      t.date :deposit_due_on
      t.references :attorney, foreign_key: true
      t.references :bond_attorney, references: :attorneys
      t.date :bond_due_on
      t.references :originator, foreign_key: true
      t.references :status, foreign_key: true
      t.date :registered_on
      t.references :bank, foreign_key: true
      t.decimal :grant_amount, precision: 14, scale: 2
      t.decimal :commission_amount, precision: 14, scale: 2
      t.decimal :tax_amount, precision: 14, scale: 2

      t.timestamps
    end

    add_foreign_key :sales, :contacts, column: :seller_id
    add_foreign_key :sales, :contacts, column: :buyer_id
    add_foreign_key :sales, :attorneys, column: :bond_attorney_id
  end
end
