class AddCommentsToSales < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :comments, :text
  end
end
