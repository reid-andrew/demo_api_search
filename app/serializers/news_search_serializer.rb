class NewsSearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :search_term, :stories
end
