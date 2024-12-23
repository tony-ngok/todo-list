class TodosController < ApplicationController
  def index # 所有任务视窗
    @todos = Todo.all
  end

  # def show # 显示任务视窗
  #   @todo = Todo.find(params[:id])
  # end

  def new # 创建任务视窗
    @todo = Todo.new
  end

  def edit # 修改任务视窗
    @todo = Todo.find(params[:id])
  end

  def create # 创建任务动作
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to todos_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update # 修改任务动作
    @todo = Todo.find(params[:id])

    if @todo.update(todo_params)
      redirect_to todos_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy # 删除任务动作
    @todo = Todo.find(params[:id])
    @todo.destroy
  
    redirect_to todos_path
  end

  private
    def todo_params
      params.require(:todo).permit(:name, :done, :important)
    end
end
