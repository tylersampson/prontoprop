# == Schema Information
#
# Table name: leases
#
#  id                  :integer          not null, primary key
#  reference           :string
#  payprop_reference   :string
#  rent_amount         :decimal(14, 2)
#  managed             :boolean
#  start_on            :date
#  end_on              :date
#  deposit_amount      :decimal(14, 2)
#  deposit_held_by     :string
#  lessor_id           :integer
#  lessee_id           :integer
#  lease_fee           :decimal(14, 2)
#  inspection_fee      :decimal(14, 2)
#  credit_check_fee    :decimal(14, 2)
#  credit_check_on     :date
#  deposit_released_on :date
#  deposit_released_to :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Lease < ApplicationRecord
  belongs_to :agent
  belongs_to :lessor, class_name: 'Contact'
  belongs_to :lessee, class_name: 'Contact'
  accepts_nested_attributes_for :lessor
  accepts_nested_attributes_for :lessee

  has_one :address, as: :addressable
  accepts_nested_attributes_for :address

  validates :reference,
    :payprop_reference,
    :rent_amount,
    :deposit_amount,
    :deposit_held_by,
    :start_on,
    :end_on,
    presence: true

  default_scope { where(customer: Customer.current_id) }

  def self.import(file)
    completed = 0
    total = 0
    CSV.foreach(file.path, :headers => true) do |row|
      lease = find_by_id(row['id']) || new
      lease.attributes = row.to_hash
      if lease.save
        completed += 1
      end
      total += 1
    end
    [total, completed]
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end
