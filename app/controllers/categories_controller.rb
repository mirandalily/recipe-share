class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    if params[:id]
      @category = Category.find(params[:id])
      @recipes = @category.recipes
      @user_recipes = current_user.recipes
    else
      @user_recipes = current_user.recipes
      @recipes = Recipe.recent.all
    end
    @categories = Category.all
  end

end
