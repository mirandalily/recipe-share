class CommentsController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :update, :delete]


  def index
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @comments, serializer: CommentSerializer }
    end
  end

  def new
    @comment = current_user.comments.build
  end

  def create
    @recipe = Recipe.find(params[:comment][:recipe_id].to_i)
    @comment = current_user.comments.build(comment_params)
    @recipe.comments << @comment
    if @comment.save
      render 'comments/show', layout: false
    else
      render 'posts/show'
    end
  end

  def show
    @recipe = Recipe.find(params[:recipe_id])
    @comments = @recipe.comments
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @comments. serializer: CommentSerializer }
    end
  end


  private

  def comment_params
      params.require(:comment).permit(:user_id, :recipe_id, :content)
  end

  def set_comment
    if params[:recipe_id].nil?
      @comment = comment.find(params[:id])
    else
      @recipe = Recipe.find(params[:recipe_id])
      @comment = @recipe.comments.find(params[:id])
    end
    return @recipe, @comment
  end

end
