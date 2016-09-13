# == Schema Information
#
# Table name: deductables
#
#  id           :integer          not null, primary key
#  name         :string
#  default_cost :decimal(10, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Deductable < ApplicationRecord
  default_scope { Customer.current_id ? where(customer: Customer.current_id) : all }
end
