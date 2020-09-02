class Api::V1::NewsSearchController < ApplicationController
  def index
    render json: NewsSearchSerializer.new(Search.new(search_params))
  end

  private

  def search_params
    params.permit(:search)
  end
end
