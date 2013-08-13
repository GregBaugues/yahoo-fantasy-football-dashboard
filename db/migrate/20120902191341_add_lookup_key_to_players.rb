class AddLookupKeyToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :lookup_key, :string

  end
end
