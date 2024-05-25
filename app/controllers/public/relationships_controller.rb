class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  def followings
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings.select { _1.is_active == true }
  end

  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers.select { _1.is_active == true }
  end
end
