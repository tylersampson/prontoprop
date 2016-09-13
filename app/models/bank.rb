# == Schema Information
#
# Table name: banks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bank < ApplicationRecord
  default_scope { Customer.current_id ? where(customer: Customer.current_id) : all }
end
