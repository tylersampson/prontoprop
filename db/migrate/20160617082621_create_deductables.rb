class CreateDeductables < ActiveRecord::Migration[5.0]
  def change
    create_table :deductables do |t|
      t.string :name
      t.decimal :default_cost, precision: 10, scale: 2

      t.timestamps
    end
  end
end
