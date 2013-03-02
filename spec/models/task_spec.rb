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

require 'spec_helper'

describe Task do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(20) }
    it { should ensure_length_of(:description).is_at_most(200) }

    context "name blank" do
      before do
        @task = build(:task, name: "")
      end

      it  "should require a name" do
        @task.should_not be_valid
      end
    end
  end
end
