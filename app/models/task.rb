# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  due_date    :date
#  done        :boolean
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  attr_accessible :description, :done, :due_date, :name, :category_id

  scope :done, where(done: true).order(:due_date)
  scope :undone, where(done: false).order("due_date desc")

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, length: { maximum: 200 }

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end
