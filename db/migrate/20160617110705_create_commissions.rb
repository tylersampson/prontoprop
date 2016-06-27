class CreateCommissions < ActiveRecord::Migration[5.0]
  def change
    create_table :commissions do |t|
      t.references :agent, foreign_key: true
      t.references :commissionable, polymorphic: true
      t.integer :agent_percent
      t.decimal :commission_amount, precision: 14, scale: 2
      t.integer :tax_percent
      t.decimal :tax_amount, precision: 14, scale: 2

      t.timestamps
    end
  end
end
