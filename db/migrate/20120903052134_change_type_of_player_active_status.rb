class ChangeTypeOfPlayerActiveStatus < ActiveRecord::Migration
  def up
    remove_column :players, :active
    add_column :players, :active, :boolean, after: :team_id
  end

  def down
  end
end
