class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|

      t.integer :user_id,     null: false
      t.integer :bookmark_id, null: false

      t.timestamps
    end
  end
end
