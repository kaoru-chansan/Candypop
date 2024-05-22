class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_customer_path(post.customer)
  end

end
