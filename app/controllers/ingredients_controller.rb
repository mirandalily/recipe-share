class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_existing_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    if params[:recipe_id]
      @recipe = Recipe.find(params[:recipe_id])
      @ingredients = @recipe.ingredients
    else
      @ingredients = Ingredient.all
    end
  end

  def new
    if !params[:recipe_id].nil?
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.build
    end
    @ingredient = Ingredient.new
    session[:referrer] = request.referer
  end

  def create
    if !params[:recipe_id].nil?
      @ingredient = Ingredient.create(ingredient_params)
      redirect_to ingredients_path
    else
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.build(ingredient_params)
      if @ingredient.save
        redirect_to recipe_path(@recipe)
      else
        render 'new'
      end
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    unless params[:recipe_id].nil?
      @recipe = Recipe.find(params[:recipe_id])
      @quantity = @recipe.recipe_ingredients.find_by(ingredient_id: @ingredient.id).quantity
    end
  end

  def show
    redirect_to @recipe
  end

  def destroy
    if params[:recipe_id]
      @ingredient.recipe_ingredients.find_by(ingredient_id: params[:id]).delete
      redirect_to recipe_path(@recipe)
    else
      @ingredient.destroy
      redirect_to ingredients_path
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def find_existing_ingredient
    if params[:recipe_id]
      @recipe = Recipe.find(params[:recipe_id])
      @ingredient = @recipe.ingredients.find(params[:id])
    else
      @ingredient = Ingredient.find(params[:id])
    end
    return @recipe, @ingredient
  end
