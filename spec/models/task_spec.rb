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

require 'spec_helper'

describe Task do
  before do
    @user = create(:user)
    5.times { create(:category, { owner_id: @user.id }) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(20) }
    it { should ensure_length_of(:description).is_at_most(200) }
    it { should belong_to(:category) }

    describe "check_association" do
      it "category check ok" do
        task = build(:task, { owner_id: @user.id })
        task.category_id = Category.first.id
        task.should be_valid
      end

      it "category check ok" do
        task = build(:task, { owner_id: @user.id })
        task.category_id = Category.maximum(:id) + 1
        task.should_not be_valid
      end
    end
  end
end
