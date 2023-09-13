class RemoveGenreFromFilms < ActiveRecord::Migration[7.0]
  def change
    remove_column :films, :genre
  end
end
