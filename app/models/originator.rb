# == Schema Information
#
# Table name: originators
#
#  id         :integer          not null, primary key
#  name       :string
#  telephone  :string
#  email      :string
#  preferred  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Originator < ApplicationRecord
  default_scope { Customer.current_id ? where(customer: Customer.current_id) : all }
end
