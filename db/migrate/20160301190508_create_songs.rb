class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :artist
      t.string :title
      t.integer :count_song

      t.timestamps 
    end
    # add_foreign_key :songs, :users
  end
end
