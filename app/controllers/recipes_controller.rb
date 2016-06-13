class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @recipes = @category.recipes
      @user_recipes = current_user.recipes
    else
      @user_recipes = current_user.recipes
      @recipes = Recipe.recent.all
    end
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
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
    params.require(:recipe).permit(:title, :description, :image, category_ids: [], ingredients_attributes: [:id, :name], directions_attributes: [:id, :step])
  end
end
