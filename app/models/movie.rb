class Movie < ApplicationRecord
  has_many :casts
  has_many :categories
  has_many :actors, through: :casts
  has_many :genres, through: :categories
end
