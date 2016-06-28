# == Schema Information
#
# Table name: sales
#
#  id                :integer          not null, primary key
#  reference         :string
#  seller_id         :integer
#  buyer_id          :integer
#  contract_start_on :date
#  purchase_price    :decimal(14, 2)
#  deposit_amount    :decimal(14, 2)
#  deposit_due_on    :date
#  attorney_id       :integer
#  bond_attorney_id  :integer
#  bond_due_on       :date
#  originator_id     :integer
#  status_id         :integer
#  registered_on     :date
#  bank_id           :integer
#  grant_amount      :decimal(14, 2)
#  commission_amount :decimal(14, 2)
#  tax_amount        :decimal(14, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Sale < ApplicationRecord
  belongs_to :seller, class_name: 'Contact'
  accepts_nested_attributes_for :seller
  belongs_to :buyer, class_name: 'Contact'
  accepts_nested_attributes_for :buyer
  belongs_to :attorney
  belongs_to :bond_attorney, class_name: 'Attorney'
  belongs_to :originator
  belongs_to :status
  belongs_to :bank

  has_one :address, as: :addressable
  accepts_nested_attributes_for :address

  has_many :commissions, as: :commissionable
  accepts_nested_attributes_for :commissions, allow_destroy: true

  validates :reference,
    :contract_start_on,
    :purchase_price,
    :deposit_amount,
    :status_id,
    :attorney_id,
    :originator_id,
    :commission_amount,
    presence: true

  before_save do
    self.tax_amount = self.commission_amount - (self.commission_amount / 1.14)
  end

  def nett_commission_amount
    commission_amount - tax_amount
  end
end
