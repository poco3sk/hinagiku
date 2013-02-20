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
end
