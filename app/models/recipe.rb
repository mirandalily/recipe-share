class Recipe < ActiveRecord::Base

  attr_accessor :quantity

  validates :title, :instructions, :description, presence: true
  has_attached_file :image, styles: { medium: "300x300>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients, dependent: :destroy
  has_many :comments
  belongs_to :user



  def self.recent
    order("recipes.updated_at DESC")
  end

  def comments_attributes=(comments_attributes)
    comments_attributes.values.each do |comment|
      if !(comments['content'] =="")
        self.comment << Comment.find_or_create_by(content: comment)
      end
    end
  end

  def ingredients_attributes=(ingredients_attributes)
    ingredients_attributes.each do |i, attribute|
      if (!(attribute.values.any? &:blank?))
        ingredient = Ingredient.find_or_create_by(name: attribute['name'])
        self.recipe_ingredients.build(ingredient_id: ingredient.id, quantity: attribute['quantity'])
      end
    end
  end

  def recipe_ingredients_attributes=(recipe_ingredients_attributes)
    recipe_ingredients_attributes.each do |i, attribute|
      if (!(attribute.values.any? &:blank?))
        self.recipe_ingredients.build(ingredient_id: attribute['id'].to_i, quantity: attribute['quantity'])
      else
        self.errors.add(:quantity, 'Oops, this can\'t be blank!')
      end
    end
  end

  def empty?
    attributes.values.compact.empty?
  end

end
