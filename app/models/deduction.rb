# == Schema Information
#
# Table name: deductions
#
#  id            :integer          not null, primary key
#  commission_id :integer
#  name          :string
#  deductable_id :integer
#  total_amount  :decimal(14, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Deduction < ApplicationRecord
  belongs_to :commission
  belongs_to :deductable

  validates :deductable_id, :name, :total_amount, presence: true
end
