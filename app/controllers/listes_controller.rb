class ListesController < ApplicationController
  before_action :set_liste, only: [:show]

  def index
    @listes = Liste.all
  end

  def show
    redirect_to liste_todos_path(@liste)
  end

  def new
    @liste = Liste.new
  end

  def edit
    @liste = Liste.find(params[:id])
  end

  def create
    @liste = Liste.new(params.require(:liste).permit(:listname))
    if @liste.save
      redirect_to listes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @liste = Liste.find(params[:id])
    if @liste.update(params.require(:liste).permit(:listname))
      redirect_to listes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @liste = Liste.find(params[:id])
    @liste.destroy
    redirect_to listes_path
  end

  private
    def set_liste
      @liste = Liste.find(params[:id])
    end
end
