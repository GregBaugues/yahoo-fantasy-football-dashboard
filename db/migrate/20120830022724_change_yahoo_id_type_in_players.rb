class ChangeYahooIdTypeInPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :yahoo_id
    remove_column :players, :ffn_id
    add_column :players, :yahoo_id, :integer, before: :yahoo_key
    add_column :players, :ffn_id, :integer, before: :yahoo_id
  end

  def down
  end
end
