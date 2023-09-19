class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show destroy]

  def index
    @movies = Movie.all
    # @movies = Movie.page(params[:page]).per(10)
    if params[:query].present?
      @movies = Movie.algolia_search(params[:query])
    end
  end

  def show
    @cast = Cast.new
    @category = Category.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movie_path(@movie)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, status: :see_other
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year, :rating, :image, :genre)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
