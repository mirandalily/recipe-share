class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :comment_id
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
