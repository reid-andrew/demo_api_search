require 'rails_helper'

RSpec.describe 'News Search - ', type: :request do
  before(:each) do
    no_term_response = File.read('spec/fixtures/no_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q")
                .to_return(status: 200, body: no_term_response, headers: {})

    baseball_term_response = File.read('spec/fixtures/baseball_search_term.json')
    stub_request(:get, "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=#{ENV['NYT_KEY']}&q=baseball")
                .to_return(status: 200, body: baseball_term_response, headers: {})
  end

  describe 'test searching for stories - ' do
    it 'finds news stories with no search term' do
      get '/api/v1/news_search'

      output = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(output[:data][:attributes][:stories].count).to eq(10)
      expect(output[:data][:id]).to eq(Search.last.id.to_s)
      expect(output[:data][:attributes][:stories][0][:web_url]).to eq("https://www.nytimes.com/reuters/2020/09/02/world/europe/02reuters-health-coronavirus-greece-russia.html")
    end

    it 'finds news stories with a search term' do
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

  describe 'test sorting stories - ' do
    it 'sorts stories found without a search term in ascending order' do
      get '/api/v1/news_search?sort=asc'

      output = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(output[:data][:attributes][:stories].count).to eq(10)
      expect(output[:data][:id]).to eq(Search.last.id.to_s)
      expect(output[:data][:attributes][:stories][0][:abstract]).to eq("Authorities in Madrid shut down a coronavirus testing center for teachers on Wednesday after large crowds formed outside, while the health ministry diagnosed 3,663 new cases of the virus, down from a peak of nearly 10,000 recorded in Spain last Friday. ")
      expect(output[:data][:attributes][:stories][1][:web_url]).to eq("https://www.nytimes.com/reuters/2020/09/02/world/europe/02reuters-russia-politics-nalvany-britain-johnson.html")
    end

    it 'sorts stories found with a search term in descending order' do
      get '/api/v1/news_search?sort=desc&search=baseball'

      output = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(output[:data][:attributes][:stories].count).to eq(10)
      expect(output[:data][:id]).to eq(Search.last.id.to_s)
      expect(output[:data][:attributes][:stories][0][:abstract]).to eq("There’s no denying his charm and genuine passion for baseball. But his habit of overstepping boundaries would have made him an uncomfortable presence if he had succeeded in purchasing the Mets.")
      expect(output[:data][:attributes][:stories][1][:web_url]).to eq("https://www.nytimes.com/2020/08/21/sports/baseball/coronavirus-mets-yankees.html")
    end

    it 'returns stories unsorted if unacceptable sort term provided' do
      get '/api/v1/news_search?sort=fail'

      output = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(output[:data][:attributes][:stories].count).to eq(10)
      expect(output[:data][:id]).to eq(Search.last.id.to_s)
      expect(output[:data][:attributes][:stories][0][:web_url]).to eq("https://www.nytimes.com/reuters/2020/09/02/world/europe/02reuters-health-coronavirus-greece-russia.html")
    end
  end
end
