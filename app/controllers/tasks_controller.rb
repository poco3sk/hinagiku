class TasksController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @tasks = @category.tasks.undone.page params[:page]
    else
      @tasks = Task.undone.page params[:page]
    end
  end

  def done
    @tasks = Task.done.page params[:page]
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
end
