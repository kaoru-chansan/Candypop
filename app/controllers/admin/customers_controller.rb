class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def destroy
    customer = Customer.find(params[:customer_id])
    post = customer.posts.find(params[:id])
    post.destroy
    redirect_to admin_customer_path(customer), notice: '投稿を削除しました。'
  end

  def withdraw
    @customer = Customer.find(params[:id])
    #!をつけて、true/falseを反転させて、有効、退会を切り替えることができる。
    @customer.update(is_active: !@customer.is_active)
      if @customer.is_active
        flash[:notice] = "退会処理を実行いたしました"
      else
        flash[:notice] = "有効にします"
      end
        redirect_to admin_customer_path
  end

end
