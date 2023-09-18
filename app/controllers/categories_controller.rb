class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @category = Category.new(category_params)
    @movie.category = @category
    if @category.save
      redirect_to movie_path(@movie)
    else
      render 'movies/show', status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:genre_id, :movie_id)
  end

end
