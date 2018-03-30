class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :micropost, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  add_index :likes, [:user_id, :created_at]
  add_index :likes, [:micropost_id, :created_at]
  end
end
