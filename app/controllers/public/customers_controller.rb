class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]
  before_action :is_matching_login_customer, only: [:edit]


  def show
    @customer = Customer.find(params[:id])
    if @customer.is_active == false
      redirect_to customers_show_path(current_customer)
    end
    @posts = @customer.posts.order(created_at: :desc)
  end

  def favorites
    @customer = Customer.find(params[:customer_id])
    if @customer
      favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
      @favorite_posts = Post.find(favorites).select { _1.customer.is_active == true }
    else
      flash[:alert] = "お気に入り処理に失敗しました。"
      redirect_to　customers_show_path
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer.id != current_customer.id || @customer.guest_customer?
      redirect_to customers_show_path(@customer.id)
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to customers_show_path(@customer.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    if @customer.id != current_customer.id
      redirect_to customers_show_path(current_customer.id)
    end
  end

  def withdraw
    @customer = Customer.find(params[:id])
    if @customer.id != current_customer.id
      redirect_to customers_show_path(current_customer.id)
    else
    # is_activeカラムをfalseに変更することにより削除フラグを立てる
      @customer.update(is_active: false)
      reset_session
      flash[:notice] = "退会処理を実行いたしました。"
      redirect_to root_path
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile, :customer_image)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.guest_customer?
      redirect_to customers_show_path(current_customer.id) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    if customer.id != current_customer.id
      redirect_to customers_show_path(current_customer.id)
    end
  end
end
