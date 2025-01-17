class ListesController < ApplicationController
  before_action :authenticate_user! # 确保用户已登入
  load_and_authorize_resource

  before_action :set_liste, only: [:show]

  def index
    @listes = current_user.listes
  end

  def show
    redirect_to liste_todos_path(@liste)
  end

  def new
    @liste = current_user.listes.build
  end

  def edit
    @liste = current_user.listes.find(params[:id])
  end

  def create
    @liste = current_user.listes.build(liste_params)
    if @liste.save
      redirect_to listes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @liste = current_user.listes.find(params[:id])
    if @liste.update(liste_params)
      redirect_to listes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @liste = current_user.listes.find(params[:id])
    @liste.destroy
    redirect_to listes_path
  end

  private
    def set_liste
      @liste = current_user.listes.find(params[:id])
    end

    def liste_params
      params.require(:liste).permit(:listname)
    end
end
