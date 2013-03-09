class TasksController < ApplicationController
  before_filter :prepare, only: [ :index, :done ]

  def index
    @tasks = @tasks.undone.page params[:page]
  end

  def done
    @tasks = @tasks.done.page params[:page]
    render :index
  end

  def search
    @tasks = Task.undone
    @tasks = @tasks.search(params[:query]) if params[:query].present?
    @tasks = @tasks.page params[:page]
    render :index
  end

  def show
    @task = Task.find(params[:id])
  rescue
    render "errors/not_found", status: 404
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes params[:task]
      redirect_to @task
    else
      render :edit
    end
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

  def restart
    @task = Task.find(params[:id])
    @task.update_attribute(:done, false)
    redirect_to :back
  end

  private
  def prepare
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @tasks = @category.tasks
    else
      @tasks = Task
    end
  end
end
