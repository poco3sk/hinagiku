# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Tasks", type: :feature do
  describe "GET /" do
    it "works!" do
      visit '/'
      page.status_code.should == 200
      page.should have_content "タスクの一覧"
    end
  end
end
