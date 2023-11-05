class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :json => "404 Not found"
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    redirect_to user_path(@user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @post.destroy
    redirect_to user_path(@user), status: :see_other
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
