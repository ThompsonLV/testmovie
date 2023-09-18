class CastsController < ApplicationController
  def new
    @cast = Cast.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @cast = Cast.new(cast_params)
    @movie.cast = @cast
    if @cast.save
      redirect_to movie_path(@movie)
    else
      render 'movies/show', status: :unprocessable_entity
    end
  end

  private

  def cast_params
    params.require(:cast).permit(:actor_id, :movie_id)
  end

end
