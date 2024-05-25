class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, except: :index

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    if @customer.is_active == false
      redirect_to customers_show_path(current_customer)
    end
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @posts = Post.all.joins(:customer).where(customer: {is_active: true}).order("posts.created_at DESC")
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path(current_customer.id)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :caption)
  end

end
