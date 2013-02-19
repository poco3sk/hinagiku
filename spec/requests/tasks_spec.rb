# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Tasks", type: :feature do
  before do
    5.times { create(:task) }
  end

  describe "new" do
    before do
      @year = 2013
      Timecop.freeze(Time.parse("#{@year}/2/17"))
    end

    it "task form" do
      visit new_task_path

      find("select#task_due_date_1i").should have_content([@year, @year + 1].join)
      find("input#task_done[type=checkbox]").should_not be_checked
    end

    after do
      Timecop.return
    end
  end

  describe "create" do
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

  describe "edit" do
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

  describe "update" do
    before do
      @task = Task.find(rand(5) + 1)
      update_str = "UPDATE TEST"
      @task.name += update_str
      @task.due_date += 1.day
      @task.description += update_str
    end

    it "update task"  do
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
