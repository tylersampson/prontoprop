# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  addressable_type :string
#  addressable_id   :integer
#  erf              :string
#  unit             :string
#  complex          :string
#  street_number    :string
#  street_name      :string
#  suburb           :string
#  city             :string
#  post_code        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street_number,
    :street_name,
    :suburb,
    :city,
    :post_code,
    presence: true

  validates :erf, presence: true, if: 'addressable.class == Sale'
  validates :unit, :complex, presence: true, if: 'addressable.class == Lease'
end
