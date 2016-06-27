class CreateDeductions < ActiveRecord::Migration[5.0]
  def change
    create_table :deductions do |t|
      t.references :commission, foreign_key: true
      t.string :name
      t.references :deductable, foreign_key: true
      t.decimal :total_amount, precision: 14, scale: 2

      t.timestamps
    end
  end
end
