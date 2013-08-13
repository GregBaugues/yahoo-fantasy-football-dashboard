class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :link
      t.string :title
      t.string :description
      t.integer :player_id
      t.datetime :published

      t.timestamps
    end
  end
end
