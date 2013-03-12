# -*- coding: utf-8 -*-
require 'spec_helper'

describe TasksController do
  before do
    @user = create(:user)
    2.times { create(:category) }
    5.times { create(:task) }
    @task = Task.find(rand(5) + 1)
    controller.stub(:current_user) { @user }
  end

  describe "index" do
    context "not login" do
      before do
        controller.stub(:current_user) { nil }
      end

      it "redirect to session new" do
        get :index

        response.should redirect_to(:new_session)
      end
    end

    context "set params category_id" do
      before do
        @target_category  = Category.last
        Task.last.update_attribute(:category_id, @target_category.id)
      end

      it "get category task" do
        get :index, category_id: @target_category.id

        assigns(:tasks).count.should == 1
      end
    end

    context "not set params" do
      it "get" do
        get :index

        assigns(:tasks).count.should == 5
      end
    end
  end

  describe "search" do
    context "params query name" do
      before do
        @name = "Search Name"
        Task.last.update_attributes({ name: "T #{@name} N", done: false })
      end

      it "get task name" do
        get :search, query: @name

        assigns(:tasks).size.should == 1
        response.should render_template(:index)
      end
    end

    context "not set params" do
      it "get task list" do
        get :search

        assigns(:tasks).size.should == 5
        response.should render_template(:index)
      end
    end
  end

  describe "show" do
    it "get" do
      get :show, id: @task.id

      assigns(:task).name.should == @task.name
      assigns(:task).description.should == @task.description
    end

    it "404 page" do
      get :show, id: Task.maximum(:id) + 1

      response.status.should == 404
      response.should render_template("errors/not_found")
    end
  end

  describe "new" do
    it "get" do
      get :new

      assigns(:task).class.should == Task
    end
  end

  describe "edit" do
    before do
      @task = Task.last
    end

    it "get" do
      get :edit, id: @task.id

      assigns(:task).should == @task
    end
  end

  describe "create" do
    before do
      request.env[:HTTP_REFERER] = root_path
      @params = { "task" =>
        {
          "name"          => "Task Name",
          "due_date(1i)"  => "2013",
          "due_date(2i)"  => "3",
          "due_date(3i)"  => "2",
          "done"          => "0",
          "description"   => "Task Description",
          "category_id"   => Category.last.id,
        }
      }
    end

    context "task create" do
      it "redirect to back" do
        post :create, @params

        response.should redirect_to(task_path(assigns(:task)))
      end
    end

    context "task not valid" do
      it "render new" do
        @params["task"]["name"] = ""
        post :create, @params

        response.should render_template(:new)
      end
    end

    context "category missing" do
      it "render new" do
        Category.last.destroy
        post :create, @params

        response.should render_template(:new)
        assigns(:task).errors.messages[:base][0].should == "指定されたカテゴリは存在しません"
      end
    end
  end

  describe "update" do
    before do
      request.env[:HTTP_REFERER] = root_path
      @update_task = create(:task)
      @params = { "task" =>
        {
          "name"          => @update_task.name,
          "due_date(1i)"  => @update_task.due_date.year,
          "due_date(2i)"  => @update_task.due_date.month,
          "due_date(3i)"  => @update_task.due_date.day,
          "done"          => @update_task.done ? 1 : 0,
          "description"   => @update_task.description
        }
      }
    end

    context "task update" do
      it "redirect to back" do
        @params["task"]["name"] = "Update Test"
        put :update, { id: @update_task.id, task: @params["task"] }

        response.should redirect_to(task_path(assigns(:task)))
      end
    end

    context "task not valid" do
      it "render edit" do
        @params["task"]["name"] = ""
        put :update, { id: @update_task.id, task: @params["task"] }

        response.should render_template(:edit)
      end
    end
  end

  describe "destroy" do
    it "delete" do
      delete :destroy, id: @task.id

      Task.count.should == 4
    end
  end

  describe "finish" do
    before do
      @task = Task.find(rand(5) + 1)
    end

    it "done task" do
      request.env["HTTP_REFERER"] = root_path
      put :finish, id: @task.id

      Task.find(@task.id).done.should be_true
    end
  end

  describe "done" do
    before do
      @target_category = Category.first
      Task.first.update_attribute(:done, true)
      Task.last.update_attributes({ done: true, category_id: @target_category.id })
    end

    context "set params category_id" do
      it "category done list" do
        get :done, category_id: @target_category.id

        assigns(:tasks).count.should == 1
      end
    end

    context "not set params category_id" do
      it "done list" do
        get :done

        assigns(:tasks).count.should == 2
      end
    end
  end

  describe "restart" do
    before do
      @task = Task.find(rand(5) + 1)
      @task.update_attribute(:done, true)
    end

    it "restart task" do
      request.env["HTTP_REFERER"] = root_path
      put :restart, id: @task.id

      Task.find(@task.id).done.should be_false
    end
  end
end
