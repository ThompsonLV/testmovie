class Movie < ApplicationRecord
  include AlgoliaSearch
  algoliasearch do
    attribute :title, :rating, :year
  end

  Movie.reindex

  has_many :casts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :actors, through: :casts
  has_many :genres, through: :categories
end
