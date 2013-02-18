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

  describe "POST CREATE" do
    before do
      @time = Time.now
      @expect_name        = "Sample Task"
      @expect_description = "Sample Description"
    end

    it "create task" do
      visit new_task_path

      within("form") do |form|
        fill_in '名称', with: @expect_name
        select @time.year, from: 'task_due_date_1i'
        select @time.month, from: 'task_due_date_2i'
        select @time.day, from: 'task_due_date_3i'
        find("input#task_done[type=checkbox]").set(true)
        fill_in '説明', with: @expect_description
      end

      click_button '送信'

      page.should have_content(@expect_name)
      page.should have_content(@expect_description)
      page.should have_content(@time.strftime("%Y-%m-%d"))
    end
  end

  describe "GET EDIT" do
    before do
      @task = Task.find(rand(5) + 1)
    end

    it "edit task page" do
      visit "/tasks/#{@task.id}/edit"

      within("form") do |form|
        find("input#task_name[type=text]").value.should have_content(@task.name)
        find("select#task_due_date_1i").value.should have_content(@task.due_date.year)
        find("select#task_due_date_2i").value.should have_content(@task.due_date.month)
        find("select#task_due_date_3i").value.should have_content(@task.due_date.day)
        find("input#task_done[type=checkbox]").should_not be_checked
        find("textarea#task_description").should have_content(@task.description)
      end
    end
  end

  describe "PUT UPDATE" do
    before do
      @task = Task.find(rand(5) + 1)
      update_str = "UPDATE TEST"
      @task.name += update_str
      @task.due_date += 1.day
      @task.description += update_str
    end

    it "update task page"  do
      visit "/tasks/#{@task.id}/edit"

      within("form") do |form|
        fill_in '名称', with: @task.name
        select @task.due_date.year, from: 'task_due_date_1i'
        select @task.due_date.month, from: 'task_due_date_2i'
        select @task.due_date.day, from: 'task_due_date_3i'
        find("input#task_done[type=checkbox]").set(true)
        fill_in '説明', with: @task.description
      end

      click_button '送信'

      page.should have_content(@task.name)
      page.should have_content(@task.description)
      page.should have_content(@task.due_date.strftime("%Y-%m-%d"))
    end
  end
end
