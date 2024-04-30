class Public::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to posts_path(current_customer.id)
  end

  def index
    @posts = Post.all
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path(current_customer.id)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :caption)
  end

end
