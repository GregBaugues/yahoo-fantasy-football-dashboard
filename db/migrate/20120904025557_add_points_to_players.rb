class AddPointsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :points, :float, after: :active
  end
end
