class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|

      t.integer "user_id", null: false, foreign_key: true
      t.string "title", null: false
      t.string "introduction", null: false
      t.string "img", null: false
      t.timestamps
    end
  end
end
