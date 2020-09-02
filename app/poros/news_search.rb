class NewsSearch
  def self.search(search_term, sort = nil)
    NewsSearch.new(collect_stories(search_term, sort))
  end

  attr_reader :id, :stories, :search_term

  def initialize(params)
    @id = params[:id]
    @stories = params[:stories]
    @search_term = params[:search_term]
  end

  private

  def self.collect_stories(search_term, sort)
    response = []
    stories = NytService.search_news(search_term)
    stories[:response][:docs].each { |story| response << Story.new(story)}
    response = order_stories(response, sort) if sort
    search_term = search_term.nil? ? "N/A" : search_term
    search = Search.create(search: search_term)
    {id: search[:id], stories: response, search_term: search_term}
  end

  def self.order_stories(stories, sort)
    return stories.sort_by { |story| story.abstract } if sort.upcase == "ASC"

    return stories.sort_by { |story| story.abstract }.reverse if sort.upcase == "DESC"

    stories
  end


end
