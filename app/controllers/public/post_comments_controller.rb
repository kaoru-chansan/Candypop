class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = post.id

    if comment.save
      flash[:notice] = "コメントしました。"
      redirect_to post_path(post)
    else
      @error_comment = comment
      @post = Post.find(params[:post_id])
      @customer = @post.customer
      @post_comment = PostComment.new
      render 'public/posts/show'
    end
  end

   def destroy
    PostComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to post_path(params[:post_id])
   end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
