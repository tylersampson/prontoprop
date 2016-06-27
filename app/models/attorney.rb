# == Schema Information
#
# Table name: attorneys
#
#  id         :integer          not null, primary key
#  name       :string
#  telephone  :string
#  email      :string
#  preferred  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attorney < ApplicationRecord
end
