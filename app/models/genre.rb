class Genre < ApplicationRecord
  has_many :movies, through: :categories

end
