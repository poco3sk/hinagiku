# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Category do
  describe "validations" do
    before do
      create(:category)
    end

    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(10) }
    it { should validate_uniqueness_of(:name).case_insensitive.with_message(/は重複しています/) }
    it { should have_many(:tasks).dependent(:nullify) }
  end
end
