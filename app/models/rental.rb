# == Schema Information
#
# Table name: rentals
#
#  id                :integer          not null, primary key
#  lease_id          :integer
#  received_on       :date
#  amount_received   :decimal(14, 2)
#  commission_amount :decimal(14, 2)
#  tax_amount        :decimal(14, 2)
#  fees_amount       :decimal(14, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'csv'

class Rental < ApplicationRecord
  belongs_to :lease
  has_many :commissions, as: :commissionable

  before_save :calculate_commissions

  def self.import(file)
    completed = 0
    total = 0
    CSV.foreach(file.path, headers: true) do |row|
      if row['BeneficiaryType'] == 'Commission'
        lease = Lease.find_by_payprop_reference(row['PropertyID'])
        if lease.present?
          rental = find_by_import_id(row['PaymentRecordID']) || new
          rental.lease = lease
          rental.received_on = Date.strptime(row['ReconDate'], '%m/%d/%Y')
          rental.amount_received = row['PaidAmount'].to_f
          rental.commission_amount = row['AfterSplitAmount'].to_f
          rental.tax_amount = rental.commission_amount * 0.14 
          rental.fees_amount = rental.amount_received * 0.015
          rental.import_id = row['PaymentRecordID']
          rental.save!
          completed += 1
        end
        total += 1
      end
    end
    [total, completed]
  end

  def nett_commission
    @nett_commission ||= commission_amount - tax_amount - fees_amount
  end

  protected
    
    def calculate_commissions
      commissions.destroy_all
      self.commissions.build(
        agent_id: lease.agent_id,
        agent_percent: 50,
        commission_amount: (nett_commission / 2)        
      )
    end
end
