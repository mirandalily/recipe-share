class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!
  before_action :set_user, only:[:index, :show, :edit, :update]

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
    if params[:category_id]
      @category = Category.find(params[:category_id])
    end
    3.times do |i|
      @ingredient = @recipe.ingredients.build
    end
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @recipe.categories << @category
    end
    if @recipe.save
      redirect_to @recipe
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
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def show
    @comment = current_user.comments.build
    @comments = @recipe.comments
    @user = current_user
    @categories = @recipe.categories
    respond_to do |format|
      format.html
      format.json { render json: @recipe.to_json(include: {comments: {only: [:content, :user_id]}})}
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: 'Deleted recipe successfully.'
  end

  private

	def set_recipe
		@recipe = Recipe.find(params[:id])
    @ingredient = @recipe.ingredients.build
    return @recipe, @ingredient
	end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instructions, :image, category_ids: [], recipe_ingredients_attributes: [:id, :quantity, :_destroy], ingredients_attributes: [:id, :name, :quantity, :_destroy], comments_attributes: [:content])
  end
end
