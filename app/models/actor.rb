class Actor < ApplicationRecord
  has_many :movies, through: :casts
end
