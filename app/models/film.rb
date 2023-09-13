class Film < ApplicationRecord
  has_many :casts
  has_many :categories

end
