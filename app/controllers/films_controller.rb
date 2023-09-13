class FilmsController < ApplicationController

  def index
    @films = Film.all
  end

  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    @film.save
    redirect_to film_path(@film)
  end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy
    redirect_to films_path, status: :see_other
  end

  private

  def film_params
    params.require(:film).permit(:title, :year, :rating, :image, :genre)
  end

end
