class CommentsController < ActionController::Base

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.user_id = @user.id
    if @comment.save
      render 'recipes/show'
    else
      render 'recipes/show'
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
