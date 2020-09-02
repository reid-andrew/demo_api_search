class Api::V1::NewsSearchController < ApplicationController
  def index
    results = NewsSearch.search(search_params[:search])
    render json: NewsSearchSerializer.new(results).serialized_json
  end

  private

  def search_params
    params.permit(:search)
  end
end
