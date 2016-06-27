class AddAgentToLease < ActiveRecord::Migration[5.0]
  def change
    add_reference :leases, :agent, foreign_key: true
  end
end
