class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    redirect_to @todo
  end

  private
    def todo_params
      params.require(:todo).permit(:name)
    end
end
