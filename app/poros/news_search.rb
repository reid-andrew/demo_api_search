class NewsSearch
  class << self
    def search(search_term)
      Search.new(search_term)
      NytService.search_news(search_term)
    end
  end
end
