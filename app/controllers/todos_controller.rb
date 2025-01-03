class TodosController < ApplicationController
  def index # 所有任务视窗
    @todos = Todo.where(liste: nil).order(:done, important: :desc)
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

  def important_many
    @importants = Todo.where(id: params[:ids])
    @importants.update_all(important: 1)

    redirect_to todos_path
  end

  def unimportant_many
    @unimportants = Todo.where(id: params[:ids])
    @unimportants.update_all(important: 0)

    redirect_to todos_path
  end

  def destroy # 删除任务动作
    @todo = Todo.find(params[:id])
    @todo.destroy
  
    redirect_to todos_path
  end

  def destroy_many
    if params[:importants] # 参数来自由视窗提交按钮内 name 值
      important_many
    elsif params[:unimportants]
      unimportant_many
    else
      @todos_delete = Todo.where(id: params[:ids])
      @todos_delete.destroy_all

      redirect_to todos_path
    end
  end

  private
    def todo_params
      params.require(:todo).permit(:name, :done, :important)
    end
end
