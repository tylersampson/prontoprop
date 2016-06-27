# == Schema Information
#
# Table name: agents
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  employee_number :string
#  mobile          :string
#  email           :string
#  tax_percent     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Agent < ApplicationRecord
  validates :first_name, :last_name, :mobile, :email, :tax_percent, presence: true

  def full_name
    first_name + " " + last_name
  end
end
