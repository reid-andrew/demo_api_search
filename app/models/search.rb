class Search < ApplicationRecord
  validates :date, presence: true
  validates :search, presence: true
end
