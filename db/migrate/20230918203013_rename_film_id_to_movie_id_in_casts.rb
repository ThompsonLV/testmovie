class RenameFilmIdToMovieIdInCasts < ActiveRecord::Migration[7.0]
  def change
    rename_column :casts, :film_id, :movie_id
    rename_column :categories, :film_id, :movie_id
  end
end
