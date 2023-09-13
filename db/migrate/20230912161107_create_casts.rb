class CreateCasts < ActiveRecord::Migration[7.0]
  def change
    create_table :casts do |t|
      t.references :actor, null: false, foreign_key: true
      t.references :film, null: false, foreign_key: true

      t.timestamps
    end
  end
end
