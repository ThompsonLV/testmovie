class Actor < ApplicationRecord
  include AlgoliaSearch
  algoliasearch do
    attributes :fullname
  end

  Actor.reindex

  has_many :casts
  has_many :movies, through: :casts

end
