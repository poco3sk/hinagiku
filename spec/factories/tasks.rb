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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "Task Name #{n}" }
    description { "Description\n" * rand(5) }
    due_date { Time.now + rand(100).days }
    done false
    owner { create(:user) }
  end
end
