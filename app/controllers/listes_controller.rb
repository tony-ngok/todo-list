class ListesController < ApplicationController
  before_action :set_liste, only: ["show"]

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

  private
    def set_liste
      @liste = Liste.find(params[:id])
    end
end
