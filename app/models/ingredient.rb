class Ingredient < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  attr_accessor :quantity

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  def recipe_ingredient_quantity(recipe_id)
    self.recipe_ingredients.find_by(recipe_id: recipe_id).quantity
  end

end
