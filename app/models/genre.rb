class Genre < ApplicationRecord
  has_many :categories
  has_many :movies, through: :categories

end
