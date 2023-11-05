class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def index
    @comments = Comment.all
  end
  def show
    begin
      @comment = Comment.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :json => "404"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    @comment.destroy
    redirect_to post_path(@post), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
