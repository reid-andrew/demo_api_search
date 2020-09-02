class NewsSearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :stories
end
