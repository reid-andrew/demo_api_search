require 'rails_helper'

RSpec.describe 'News Search - ', type: :request do
  before(:each) do
    no_term_response = File.read('spec/fixtures/no_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q")
                .to_return(status: 200, body: no_term_response, headers: {})
  end

  it 'finds news stories' do
    get '/api/v1/news_search'

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end
