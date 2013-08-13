class AddFirstNameAndLastNameToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
  end
end
