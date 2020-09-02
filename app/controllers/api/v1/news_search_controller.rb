class Api::V1::NewsSearchController < ApplicationController
  def index
    render json: NewsSearchSerializer.new(NewsSearch.search(search_params[:search]))
  end

  private

  def search_params
    params.permit(:search)
  end
end
