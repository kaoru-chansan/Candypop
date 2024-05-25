class Public::SearchesController < ApplicationController
    before_action :authenticate_customer!

  def search_result
    @range = params[:range]

    if @range == "Customer"
      @customers = Customer.looks(params[:word]).where(is_active: true)
    else
      @posts = Post.joins(:customer).where(customer: {is_active: true}).looks(params[:word])
    end
  end

end
