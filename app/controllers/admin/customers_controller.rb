class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :if_not_admin

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def destroy
    customer = Customer.find(params[:id])
    post = customer.posts.find(params[:id])
    post.destroy
    redirect_to admin_customer_path(customer), notice: '投稿を削除しました。'
  end

  def withdraw
    @customer = Customer.find(params[:id])
    #!をつけて、true/falseを反転させて、有効、退会を切り替えることができる。
    @customer.update(is_active: !@customer.is_active)
      if @customer.is_active
        flash[:notice] = "有効にします"
      else
        flash[:notice] = "退会処理を実行いたしました"
      end
        redirect_to admin_customer_path
  end

  private
    def if_not_admin
      unless current_customer.nil? || !current_customer.admin?
        redirect_to root_path
      end
    end

end
