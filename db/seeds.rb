# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

p '--------------------'
p 'Destruction des données'
p '--------------------'

Film.destroy_all

p 'Création des données'
p '--------------------'
url = "https://gist.githubusercontent.com/alexandremeunier/49533eebe2ec93b14d32b2333272f9f8/raw/924d89e2236ca6fa2ade7481c91bfbf858c49531/movies.json"
films_serialized = URI.open(url).read
films = JSON.parse(films_serialized)

films.take(50).each do |film|
  Film.create(title: film['title'], year: film['year'], rating: film['rating'], image: film['image'])
  Genre.create(content: film['genre'])
  Actor.create(content: film['genre'])
end

p 'Terminé'
p '--------------------'
