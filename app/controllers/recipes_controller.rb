class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!

  def index
    @recipe = current_user.recipes
    @all_recipes = Recipe.all
    @user = User.find_by(params[:id])
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
    params.require(:recipe).permit(:title, :description, :image, category_ids:[], ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end
end
