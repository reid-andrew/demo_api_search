class NewsSearch
  def self.search(search_term)
    NewsSearch.new(collect_stories(search_term))
  end

  attr_reader :id, :stories

  def initialize(params)
    @id = params[:id]
    @stories = params[:stories]
  end

  private

  def self.collect_stories(search_term)
    response = []
    stories = NytService.search_news(search_term)
    stories[:response][:docs].each { |story| response << Story.new(story)}
    search_term = search_term.nil? ? "N/A" : search_term
    search = Search.create(search: search_term)
    {id: search[:id], stories: response}
  end
end
