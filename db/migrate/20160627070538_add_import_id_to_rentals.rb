class AddImportIdToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :import_id, :string
  end
end
