class AddYahooKeyToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :yahoo_key, :string, after: :yahoo_id
  end
end
