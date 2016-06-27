# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  nature     :string
#  can_edit   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Status < ApplicationRecord
end
