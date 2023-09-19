class Genre < ApplicationRecord
  include AlgoliaSearch
  algoliasearch do
    attributes :content
  end

  has_many :categories
  has_many :movies, through: :categories

end
