class Recipe < ActiveRecord::Base
  attr_accessor :quantity

  validates :title, :instructions, :description, presence: true
  has_attached_file :image, styles: { medium: "250x250#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients
  has_many :user_comments
  has_many :comments, through: :user_comments
  has_many :categories, through: :recipe_categories
  has_many :recipe_categories
  belongs_to :user

  # testing out adding dynamic fields
  accepts_nested_attributes_for :ingredients, :allow_destroy => true


  def self.recent
    order("recipes.updated_at DESC")
  end

  def ingredients_attributes=(ingredients_attributes)
    if !errors.any?
      ingredients_attributes.each do |i,attribute|
        ingredient = Ingredient.find_or_create_by(name: attribute[:name].downcase.titlecase)
        self.recipe_ingredients.build(ingredient_id: ingredient.id, quantity: attribute[:quantity])
      end
    end
  end

  def recipe_ingredients_attributes=(recipe_ingredients_attributes)
    recipe_ingredients_attributes.each do |i, attribute|
      if (!(ingredient_attr.values.any? &:blank?))
        self.recipe_ingredients.build(ingredient_id: attribute[:id].to_i, quantity: attribute[:quantity])
      else
        self.errors.add(:quantity, 'Oops, this can\'t be blank!')
      end
    end
  end

end
