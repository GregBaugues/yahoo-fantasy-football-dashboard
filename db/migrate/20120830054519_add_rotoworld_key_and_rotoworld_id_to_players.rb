class AddRotoworldKeyAndRotoworldIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :rotoworld_key, :string

    add_column :players, :rotoworld_id, :integer

  end
end
