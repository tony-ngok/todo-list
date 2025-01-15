class TodosController < ApplicationController
  before_action :authenticate_user! # 确保用户已登入
  load_and_authorize_resource

  # 过滤器
  before_action :with_list, only: [:index, :new, :create, :edit, :update] # 检查是否有上级 Liste 实例

  def index # 所有任务视窗
    if @liste
      @todos = @liste.todos.order(:done, important: :desc)
    else
      @todos = current_user.todos.where(liste_id: nil).order(:done, important: :desc)
    end
  end

  def new # 创建任务视窗
    if @liste
      @todo = @liste.todos.build # 在父模型实例 Liste 的上下文创建
    else
      @todo = current_user.todos.build
    end
  end

  def edit # 修改任务视窗
    if @liste
      @todo = @liste.todos.find(params[:id])
    else
      @todo = current_user.todos.find(params[:id])
    end
  end

  def create # 创建任务动作
    if @liste
      @todo = @liste.todos.build(todo_params)
    else
      @todo = current_user.todos.build(todo_params)
    end

    if @todo.save
      back(@liste)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update # 修改任务动作
    find_todo(@liste)
    if @todo.update(todo_params)
      back(@todo.liste)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def important_many
    @importants = current_user.todos.where(id: params[:ids])
    if !@importants.empty?
      @importants.update_all(important: 1)
      back(@importants.first.liste)
    end
  end

  def unimportant_many
    @unimportants = current_user.todos.where(id: params[:ids])
    if !@unimportants.empty?
      @unimportants.update_all(important: 0)
      back(@unimportants.first.liste)
    end
  end

  def destroy # 删除任务动作
    @todo = current_user.todos.find(params[:id])
    @todo.destroy
    back(@todo.liste)
  end

  def destroy_many
    if params[:importants] # 参数来自由视窗提交按钮内 name 值
      important_many
    elsif params[:unimportants]
      unimportant_many
    else
      @todos_delete = current_user.todos.where(id: params[:ids])
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
      @liste = current_user.listes.find_by(id: params[:liste_id])
    end

    def find_todo(l)
      if @liste
        @todo = @liste.todos.find(params[:id])
      else
        @todo = current_user.todos.find(params[:id])
      end
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
