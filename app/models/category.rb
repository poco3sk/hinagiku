# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'nkf'

class Category < ActiveRecord::Base
  has_many :tasks, dependent: :nullify
  belongs_to :owner, class_name: "User"

  attr_accessible :name, :owner

  validates :name, presence: true, length: { maximum: 10 },
            uniqueness: { case_sensitive: false }

  before_validation :normalize_values

  IDEOGRAPHIC_SPACE = [ 0x3000 ].pack("U")
  WHITESPACES       = "[\s#{IDEOGRAPHIC_SPACE}]"

  private
  def normalize_values
    if name.present?
      self.name = NKF.nkf("-WwZ", name)
      self.name = name.sub(/^#{WHITESPACES}+/, "")
      self.name = name.sub(/#{WHITESPACES}+$/, "")
    end
  end
end
