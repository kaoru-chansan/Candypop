class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user, only: [:edit]

  def index
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
     @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     redirect_to customers_show_path(@customer.id)
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(params[:id])
    # is_activeカラムをfalseに変更することにより削除フラグを立てる
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile, :password, :customer_image)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.guest_customer?
      redirect_to customers_show_path(current_customer.id) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
