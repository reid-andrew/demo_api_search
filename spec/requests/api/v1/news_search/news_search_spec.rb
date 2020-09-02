require 'rails_helper'

RSpec.describe 'News Search - ', type: :request do
  it 'finds news stories with no search term' do
    no_term_response = File.read('spec/fixtures/no_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q")
                .to_return(status: 200, body: no_term_response, headers: {})

    get '/api/v1/news_search'

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(output[:data][:attributes][:stories].count).to eq(10)
    expect(output[:data][:id]).to eq(Search.last.id.to_s)
    expect(output[:data][:attributes][:stories][0][:web_url]).to eq("https://www.nytimes.com/reuters/2020/09/02/world/europe/02reuters-health-coronavirus-greece-russia.html")
  end

  it 'finds news stories with a search term' do
    baseball_term_response = File.read('spec/fixtures/baseball_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q=baseball")
                .to_return(status: 200, body: baseball_term_response, headers: {})

    get '/api/v1/news_search?search=baseball'

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(output[:data][:attributes][:stories].count).to eq(10)
    expect(output[:data][:id]).to eq(Search.last.id.to_s)
    expect(output[:data][:attributes][:stories][0][:web_url]).to eq("https://www.nytimes.com/2020/08/28/sports/baseball/mlb-protest-canceled-games.html")
    expect(output[:data][:attributes][:stories][1][:abstract]).to eq("The Dodgers are 22-8 after 30 games of a 60-game season that will be remembered for postponed games, health-driven rules and expanded playoffs.")
  end
end
