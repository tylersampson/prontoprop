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
require 'csv'

class Agent < ApplicationRecord
  validates :first_name, :last_name, :mobile, :email, :tax_percent, presence: true

  default_scope { where(customer: Customer.current_id) }

  def full_name
    first_name + " " + last_name
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    total = 0
    CSV.foreach(file.path, headers: true) do |row|
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice('first_name', 'last_name', 'email', 'mobile', 'tax_percent', 'employee_number')
      product.save!
      total += 1
    end
    total
  end
end
