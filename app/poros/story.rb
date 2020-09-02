class Story
  attr_reader :abstract,
              :web_url,
              :snippet,
              :lead_paragraph,
              :source,
              :pub_date

  def initialize(data)
    @abstract = data[:abstract]
    @web_url = data[:web_url]
    @snippet = data[:snippet]
    @lead_paragraph = data[:lead_paragraph]
    @source = data[:source]
    @pub_date = data[:pub_date]
  end
end
