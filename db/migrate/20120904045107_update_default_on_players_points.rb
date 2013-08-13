class UpdateDefaultOnPlayersPoints < ActiveRecord::Migration
  def up
    change_column_default :players, :points, 0
  end

  def down
  end
end
