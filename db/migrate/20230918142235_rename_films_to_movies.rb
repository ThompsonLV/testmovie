class RenamemoviesToMovies < ActiveRecord::Migration[7.0]
  def change
    rename_table :movies, :movies
  end
end
