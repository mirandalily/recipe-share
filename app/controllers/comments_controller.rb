class CommentsController < ActionController::Base
  before_action :authenticate_user!


  def create
    @recipe = Recipe.find_by(id: comment_params[:recipe_id])
    @comment = @recipe.comments.create(comment_params)
    redirect_to @recipe
  end

  def show
  end


  private

  def comment_params
      params.require(:comment).permit(:user_id, :recipe_id, :content)
  end

end
