class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :nature
      t.boolean :can_edit

      t.timestamps
    end
  end
end
