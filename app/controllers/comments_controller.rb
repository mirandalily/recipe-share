class CommentsController < ActionController::Base
  before_action :authenticate_user!


  def create
    @recipe = Recipe.find_by(id: comment_params[:recipe_id])
    @comment = current_user.comments.create(comment_params)
    @recipe.comments << @comment
    respond_to do |format|
      format.html {redirect_to @recipe}
      format.json {render json: {content: @comment.content}}

  end

  def show
    render 'comments/show', layout: false
    render json: @comments
  end


  private

  def comment_params
      params.require(:comment).permit(:user_id, :recipe_id, :content)
  end

end
