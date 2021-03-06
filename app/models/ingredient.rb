class Ingredient < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  attr_accessor :quantity

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  def recipe_ingredient_quantity(recipe_id)
    self.recipe_ingredients.find_by(recipe_id: recipe_id).quantity
  end

  def empty?
    attributes.values.compact.empty?
  end

end
