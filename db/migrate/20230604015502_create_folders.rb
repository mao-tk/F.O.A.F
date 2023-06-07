class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|

      t.integer :user_id
      t.integer :bookmark_id

      t.timestamps
    end
  end
end
