class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :instructions, :user_id
  has_many :comments
end
