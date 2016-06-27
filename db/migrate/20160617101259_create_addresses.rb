class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :erf
      t.string :unit
      t.string :complex
      t.string :street_number
      t.string :street_name
      t.string :suburb
      t.string :city
      t.string :post_code

      t.timestamps
    end
  end
end
