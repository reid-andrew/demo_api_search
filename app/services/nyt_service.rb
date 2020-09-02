class NytService
  class << self
    def search_news(search_term)
      parse_json(connection(search_term))
    end

    private

    def connection(search_term)
      url = 'https://api.nytimes.com/svc/search/v2/articlesearch.json'
      Faraday.get(url) do |req|
        req.params['q'] = search_term
        req.params['api-key'] = ENV['NYT_KEY']
      end
    end

    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
