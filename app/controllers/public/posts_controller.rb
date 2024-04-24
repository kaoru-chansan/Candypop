class Public::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def edit
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

  private

  def post_params
    params.require(:post).permit(:post_image, :caption)
  end

end
