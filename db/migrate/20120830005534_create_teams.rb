class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :yahoo_id
      t.string :yahoo_key
      t.integer :yahoo_owner_id
      t.string :yahoo_owner_name
      t.string :name

      t.timestamps
    end
  end
end
