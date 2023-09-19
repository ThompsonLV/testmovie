class Genre < ApplicationRecord
  include AlgoliaSearch
  algoliasearch do
    attribute :content
  end

  Genre.reindex

  has_many :categories
  has_many :movies, through: :categories

end
