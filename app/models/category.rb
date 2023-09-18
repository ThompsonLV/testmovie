class Category < ApplicationRecord
  belongs_to :genre
  belongs_to :movie
end
