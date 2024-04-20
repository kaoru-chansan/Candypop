class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

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
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :profile, :password, :customer_image)
  end
end
