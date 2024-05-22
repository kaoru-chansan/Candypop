class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    PostComment.find(params[:id]).destroy
    customer = Post.customer
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_customer_path(customer)
  end

end
