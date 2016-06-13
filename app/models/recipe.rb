class Recipe < ActiveRecord::Base
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :ingredients
  has_many :directions
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  has_attached_file :image, styles: { medium: "200x200#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :directions


  def self.recent
    order("recipes.updated_at DESC")
  end

  def ingredients_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |ingredient_attribute|
      ingredient = Ingredient.find_or_create_by(ingredient_attribute) if ingredient_attribute[:name].present?
      self.ingredients << ingredient if ingredient
    end
  end

  def directions_attributes=(direction_attributes)
    direction_attributes.values.each do |direction_attribute|
      direction = Direction.find_or_create_by(direction_attribute) if direction_attribute[:step].present?
      self.directions << direction if direction
    end
  end

end
