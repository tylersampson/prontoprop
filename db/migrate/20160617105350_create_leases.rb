class CreateLeases < ActiveRecord::Migration[5.0]
  def change
    create_table :leases do |t|
      t.string :reference
      t.string :payprop_reference
      t.decimal :rent_amount, precision: 14, scale: 2
      t.boolean :managed
      t.date :start_on
      t.date :end_on
      t.decimal :deposit_amount, precision: 14, scale: 2
      t.string :deposit_held_by
      t.references :lessor, references: :contacts
      t.references :lessee, references: :contacts
      t.decimal :lease_fee, precision: 14, scale: 2
      t.decimal :inspection_fee, precision: 14, scale: 2
      t.decimal :credit_check_fee, precision: 14, scale: 2
      t.date :credit_check_on
      t.date :deposit_released_on
      t.string :deposit_released_to

      t.timestamps
    end

    add_foreign_key :leases, :contacts, column_name: :lessor_id
    add_foreign_key :leases, :contacts, column_name: :lessee_id
  end
end
