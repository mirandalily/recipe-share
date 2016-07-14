class RecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredient_id, index: true, foreign_key: true
      t.integer :recipe_id, index: true, foreign_key: true
      t.string :quantity
    end
  end
end
