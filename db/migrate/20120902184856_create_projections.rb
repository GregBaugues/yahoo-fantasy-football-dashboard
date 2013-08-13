class CreateProjections < ActiveRecord::Migration
  def change
    create_table :projections do |t|
      t.integer :player_id
      t.integer :week
      t.float :standard
      t.float :standard_low
      t.float :standard_high
      t.float :ppr
      t.float :ppr_low
      t.float :ppr_high

      t.timestamps
    end
  end
end
