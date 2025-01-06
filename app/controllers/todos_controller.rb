class TodosController < ApplicationController
  # 过滤器
  before_action :with_list, only: [:index, :new, :create] # 检查是否有上级 Liste 实例

  def index # 所有任务视窗
    if @liste
      @todos = @liste.todos.order(:done, important: :desc)
    else
      @todos = Todo.where(liste_id: nil).order(:done, important: :desc)
    end
  end

  # def show # 显示任务视窗
  #   @todo = Todo.find(params[:id])
  # end

  def new # 创建任务视窗
    if @liste
      @todo = @liste.todos.build # 在父模型实例 Liste 的上下文创建
    else
      @todo = Todo.new
    end
  end

  def edit # 修改任务视窗
    @todo = Todo.find(params[:id])
  end

  def create # 创建任务动作
    puts @liste
    if @liste
      @todo = @liste.todos.build(todo_params)
    else
      @todo = Todo.new(todo_params)
    end

    if @todo.save
      back(@liste)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update # 修改任务动作
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      back(@todo.liste)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def important_many
    @importants = Todo.where(id: params[:ids])
    if !@importants.empty?
      @importants.update_all(important: 1)
      back(@importants.first.liste)
    end
  end

  def unimportant_many
    @unimportants = Todo.where(id: params[:ids])
    if !@unimportants.empty?
      @unimportants.update_all(important: 0)
      back(@unimportants.first.liste)
    end
  end

  def destroy # 删除任务动作
    @todo = Todo.find(params[:id])
    @todo.destroy
    back(@todo.liste)
  end

  def destroy_many
    if params[:importants] # 参数来自由视窗提交按钮内 name 值
      important_many
    elsif params[:unimportants]
      unimportant_many
    else
      @todos_delete = Todo.where(id: params[:ids])
      if !@todos_delete.empty?
        @todos_liste = @todos_delete.first.liste
        @todos_delete.destroy_all
        back(@todos_liste)
      end
    end
  end

  private
    def with_list
      # 根据列表 id，判断当前视窗是否属于一个列表
      # find 方法不允许空 id，所以用 find_by(id:)
      # find_by(id: nil) -> nil
      @liste = Liste.find_by(id: params[:liste_id])
    end

    def back(l)
      if l
        redirect_to liste_todos_path(l)
      else
        redirect_to todos_path
      end
    end

    def todo_params
      params.require(:todo).permit(:name, :done, :important)
    end
end
