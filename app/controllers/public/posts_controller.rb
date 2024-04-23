class Public::PostsController < ApplicationController
  def show
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
    redirect_to post_path(current_customer.id)
  end

  def index
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

end
