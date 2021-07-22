class CreateContentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :content_categories do |t|

      t.integer :category_id, null: false
      t.integer :content_id, null: false

      t.timestamps
    end
  end
end
