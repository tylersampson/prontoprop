class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.references :lease, foreign_key: true
      t.date :received_on
      t.decimal :amount_received, precision: 14, scale: 2
      t.decimal :commission_amount, precision: 14, scale: 2
      t.decimal :tax_amount, precision: 14, scale: 2
      t.decimal :fees_amount, precision: 14, scale: 2

      t.timestamps
    end
  end
end
