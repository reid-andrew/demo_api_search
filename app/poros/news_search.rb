class NewsSearch
  class << self
    def search(search_term)
      collect_stories(search_term)
    end

    private

    def collect_stories(search_term)
      response = []
      stories = NytService.search_news(search_term)
      stories[:response][:docs].each { |story| response << Story.new(story)}
      search_term = search_term.nil? ? "N/A" : search_term
      search = Search.create(search: search_term)
      {id: search[:id], stories: response}
    end
  end
end
