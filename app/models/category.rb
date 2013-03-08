# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :tasks, dependent: :nullify

  attr_accessible :name

  validates :name, presence: true, length: { maximum: 10 },
            uniqueness: { case_sensitive: false }
end
