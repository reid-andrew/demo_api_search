require 'rails_helper'

RSpec.describe 'News Search - ', type: :request do
  it 'finds news stories' do
    get '/api/v1/news_search?search=election'

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end
