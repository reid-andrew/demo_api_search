class Api::V1::NewsSearchController < ApplicationController
  def index
    results = NewsSearch.search(search_params[:search], search_params[:sort])
    render json: NewsSearchSerializer.new(results).serialized_json
  end

  private

  def search_params
    params.permit(:search, :sort)
  end
end
