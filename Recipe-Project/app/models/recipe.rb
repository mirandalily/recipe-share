class Recipe < ActiveRecord::Base
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :ingredients
  has_many :directions
  belongs_to :user
  has_attached_file :image, styles: { medium: "200x200#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  accepts_nested_attributes_for :ingredients,
  															reject_if: proc { |attributes| attributes['name'].blank? },
  															allow_destroy: true
 	accepts_nested_attributes_for :directions,
  															reject_if: proc { |attributes| attributes['step'].blank? },
  															allow_destroy: true
  def self.events_by_category(category)
    if category == nil
      all
    else
      where("category = ?", category)
    end
  end

end
