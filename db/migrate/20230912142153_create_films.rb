class Createmovies < ActiveRecord::Migration[7.0]
  def change
    create_table :films do |t|
      t.string :title
      t.integer :year
      t.integer :rating
      t.string :image
      t.string :genre

      t.timestamps
    end
  end
end
