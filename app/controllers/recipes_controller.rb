class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!
  before_action :set_user, only:[:index,:show]

  def index
      @user_recipes = current_user.recipes
      @recipes = Recipe.recent.all
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @ingredients = Ingredient.all
  end

  def create
    @recipe = Recipe.create(recipe_params)
    @ingredients = Ingredient.all
    if @recipe.persisted?
      redirect_to recipe_path(@recipe)
    else
      3.times do |i|
        @ingredient = @recipe.ingredients.build
      end
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def show
    @comment = @recipe.comments.build
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: 'Deleted recipe successfully.'
  end

  private

	def set_recipe
		@recipe = Recipe.find(params[:id])
	end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instructions, :image, category_ids: [], recipe_ingredients_attributes: [:id, :quantity, :_destroy], ingredients_attributes: [:id, :name, :quantity, :_destroy])
  end
end
