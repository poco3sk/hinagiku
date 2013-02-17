# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Tasks", type: :feature do
  before do
    5.times { create(:task) }
  end

  describe "GET /" do
    it "works!" do
      visit root_path
      page.status_code.should == 200
      page.should have_content "タスクの一覧"
    end

    it "task list index" do
      visit root_path
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

  describe "GET NEW" do
    before do
      @year = 2013
      Timecop.freeze(Time.parse("#{@year}/2/17"))
    end

    it "task form" do
      visit new_task_path

      within("form") do |form|
        find("input#task_name[type=text]").should have_content("")
        find("select#task_due_date_1i").should have_content([@year, @year + 1].join)
        (1..3).each { |i| find("select#task_due_date_#{i}i").should be }
        find("input#task_done[type=checkbox]").should_not be_checked
        find("input[type=submit]").value.should == "送信"
      end
    end

    after do
      Timecop.return
    end
  end
end
