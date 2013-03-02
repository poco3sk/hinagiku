# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  due_date    :date
#  done        :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "Task Name #{n}" }
    description { "Description\n" * rand(10) }
    due_date { Time.now + rand(100).days }
    done false
  end
end
