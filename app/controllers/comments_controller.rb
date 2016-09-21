class CommentsController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :update, :delete]

  def create
    @recipe = Recipe.find(params[:comment][:recipe_id].to_i)
    @recipe.comments.create(comment_params)
      redirect_to recipe_path(@recipe)
  end

  def index
    @comments = Comment.all
  end

  def new
    @comment = @recipe.comments.build
  end

  def show
    @comment = Comment.new
  end


  private

  def set_comment
    if params[:recipe_id].nil?
      @comment = comment.find(params[:id])
    else
      @recipe = Recipe.find(params]:recipe_id)
      @comment = @recipe.comments.find(params[:id])
    end
    return @recipe, @comment
  end

  def comment_params
      params.require(:comment).permit(:user_id, :content)
  end

end
