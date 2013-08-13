class CreatePlayers < ActiveRecord::Migration
  def up
    create_table "players", :force => true do |t|
      t.string   "name"
      t.string   "position"
      t.string   "team"
      t.string   "injury_status"
      t.string   "bye_week"
      t.string   "ffn_id"
      t.string   "yahoo_id"
      t.integer  "team_id"
      t.string   "active"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
  end
end
