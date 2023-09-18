class Movie < ApplicationRecord
  has_many :actors, through: :categories
  has_many :genres, through: :casts
end
