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
end
