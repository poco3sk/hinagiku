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

    describe "normalize_values" do
      context "zenkaku => hankaku" do
        let(:expect) { "abcdefg" }
        subject { create(:category, name: "ａｂｃｄｅｆｇ") }
        it { subject.name.should == expect }
      end

      context "hankaku kana => zenkaku kana" do
        let(:expect) { "アイウエオベ" }
        subject { create(:category, name: "ｱｲｳｴｵﾍﾞ") }
        it { subject.name.should == expect }
      end

      context "space trim" do
        let(:expect) { "ウエオベ" }
        subject { create(:category, name: "   ｳｴｵﾍﾞ  ") }
        it { subject.name.should == expect }
      end

      context "zenkaku space trim" do
        let(:expect) { "aefg" }
        subject { create(:category, name: "　　ａｅｆｇ　") }
        it { subject.name.should == expect }
      end

      context "mix" do
        let(:expect) { "ae ヤ　ァg" }
        subject { create(:category, name: "　 　ａｅ ﾔ　ｧｇ　 ") }
        it { subject.name.should == expect }
      end
    end
  end
end
