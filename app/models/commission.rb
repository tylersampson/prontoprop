# == Schema Information
#
# Table name: commissions
#
#  id                  :integer          not null, primary key
#  agent_id            :integer
#  commissionable_type :string
#  commissionable_id   :integer
#  agent_percent       :integer
#  commission_amount   :decimal(14, 2)
#  tax_percent         :integer
#  tax_amount          :decimal(14, 2)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Commission < ApplicationRecord
  belongs_to :agent
  belongs_to :commissionable, polymorphic: true
  has_many :deductions
  accepts_nested_attributes_for :deductions, allow_destroy: true

  validates :agent_id, :agent_percent, presence: true

  before_save do
    self.tax_percent = self.agent.tax_percent
    self.commission_amount = self.commissionable.nett_commission_amount * self.agent_percent / 100.0
    self.tax_amount = self.commission_amount * self.tax_percent / 100.0
  end

  def nett_commission_amount
    @nett_commission_amount ||= commission_amount - tax_amount
  end

  def total_deductions
    @total_deductions ||= deductions.sum(:total_amount)
  end

  def nett_due
    @nett_due ||= nett_commission_amount - total_deductions
  end
end
