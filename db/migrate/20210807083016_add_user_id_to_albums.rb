class AddUserIdToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :Albums, :user_id, :integer
  end
end
