class Movie < ApplicationRecord
  has_many :casts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :actors, through: :casts
  has_many :genres, through: :categories
end
