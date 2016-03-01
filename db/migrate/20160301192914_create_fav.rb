class CreateFav < ActiveRecord::Migration
  def change
    create_table :favs do |t|
      t.references :user, index: true
      t.references :song, index: true
      t.integer :count_fav

      t.timestamps null: false
    end
    add_foreign_key :favs, :users
    add_foreign_key :favs, :songs
  end
end
