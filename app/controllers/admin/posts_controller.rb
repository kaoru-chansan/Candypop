class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    post = Posts.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_customer_path(customer)
  end

end
