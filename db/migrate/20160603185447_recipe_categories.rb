class RecipeCategories < ActiveRecord::Migration
  def change
    create_table :recipe_categories do |t|
      t.integer :category_id, index: true, foreign_key: true
      t.integer :recipe_id, index: true, foreign_key: true
    end
  end
end
