require 'rails_helper'

RSpec.describe 'NYT Service - ', type: :feature do
  it 'finds news stories with no search term' do
    no_term_response = File.read('spec/fixtures/no_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q")
                .to_return(status: 200, body: no_term_response, headers: {})

    response = NytService.search_news(nil)

    expect(response[:status]).to eq("OK")
    expect(response[:response][:docs].size).to eq(10)
    expect(response[:response][:docs][0][:snippet]).to eq("Greece will require visitors from Russia to show a negative COVID-19 test before entering the country between Sept. 7 and Sept. 21, its civil aviation authority said on Wednesday.")
  end

  it 'finds news stories with a search term' do
    baseball_term_response = File.read('spec/fixtures/baseball_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q=baseball")
                .to_return(status: 200, body: baseball_term_response, headers: {})

    response = NytService.search_news('baseball')

    expect(response[:status]).to eq("OK")
    expect(response[:response][:docs].size).to eq(10)
    expect(response[:response][:docs][0][:multimedia].size).to eq(74)
  end
end
