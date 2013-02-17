# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Tasks", type: :feature do
  before do
    5.times { create(:task) }
  end

  describe "GET /" do
    it "works!" do
      visit '/'
      page.status_code.should == 200
      page.should have_content "タスクの一覧"
    end

    it "task list index" do
      visit '/'
      Task.all.each do |t|
        page.should have_content t.name
      end
    end
  end

  describe "GET SHOW" do
    it "show task" do
      task = Task.last
      visit "/tasks/#{task.id}"
      find('#task_due_date').should have_content(task.due_date)
      find('#task_description').should have_content(task.description)
    end
  end
end
