require 'spec_helper'

describe TasksController do
  before do
    5.times { create(:task) }
    @task = Task.find(rand(5) + 1)
  end

  describe "index" do
    it "get" do
      get :index
      assigns(:tasks).count.should == 5
    end
  end

  describe "show" do
    it "get" do
      get :show, id: @task.id
      assigns(:task).name.should == @task.name
      assigns(:task).description.should == @task.description
    end
  end

  describe "create" do
    before do
      request.env[:HTTP_REFERER] = root_path
      @params     = { "task" =>
        {
          "name"          => "Task Name",
          "due_date(1i)"  => "2013",
          "due_date(2i)"  => "3",
          "due_date(3i)"  => "2",
          "done"          => "0",
          "description"   => "Task Description"
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
      Task.first.update_attribute(:done, true)
      Task.last.update_attribute(:done, true)
    end

    it "done list" do
      get :done

      assigns(:tasks).count.should == 2
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
