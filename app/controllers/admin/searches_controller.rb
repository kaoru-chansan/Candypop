class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search_result
    @range = params[:range]

    if @range == "Customer"
      @customers = Customer.looks(params[:word])
    else
      @posts = Post.looks(params[:word])
    end
  end
end
