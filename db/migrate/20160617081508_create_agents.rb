class CreateAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :employee_number
      t.string :mobile
      t.string :email
      t.integer :tax_percent

      t.timestamps
    end
  end
end
