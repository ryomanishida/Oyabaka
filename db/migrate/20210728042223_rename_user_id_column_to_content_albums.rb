class RenameUserIdColumnToContentAlbums < ActiveRecord::Migration[5.2]
  def change
    rename_column :content_albums, :user_id, :album_id
  end
end
