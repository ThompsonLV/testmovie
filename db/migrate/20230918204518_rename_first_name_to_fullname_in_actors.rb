class RenameFirstNameToFullnameInActors < ActiveRecord::Migration[7.0]
  def change
    rename_column :actors, :first_name, :fullname
    remove_column :actors, :last_name
    add_column :actors, :avatar, :string
  end
end
