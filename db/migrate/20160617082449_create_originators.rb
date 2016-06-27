class CreateOriginators < ActiveRecord::Migration[5.0]
  def change
    create_table :originators do |t|
      t.string :name
      t.string :telephone
      t.string :email
      t.boolean :preferred

      t.timestamps
    end
  end
end
