class CreateContentAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :content_albums do |t|
      t.integer :content_id
      t.integer :album_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
