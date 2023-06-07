class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.integer :area_id
      t.integer :tag_id
      t.string  :title
      t.text    :body
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
