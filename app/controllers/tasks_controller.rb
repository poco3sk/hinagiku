class TasksController < ApplicationController
  def index
    @tasks = Task.where(done: false)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.create(params[:task])
    redirect_to @task
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes params[:task]
    redirect_to @task
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to :tasks
  end

  def finish
    @task = Task.find(params[:id])
    @task.update_attribute(:done, true)
    redirect_to :back
  end
end
