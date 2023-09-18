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

Movie.destroy_all
Genre.destroy_all
Actor.destroy_all
Cast.destroy_all
Category.destroy_all

p 'Création des données'
p '--------------------'
url = "https://gist.githubusercontent.com/alexandremeunier/49533eebe2ec93b14d32b2333272f9f8/raw/924d89e2236ca6fa2ade7481c91bfbf858c49531/movies.json"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

index = 0

movies.take(100).each do |movie|
  new_movie = Movie.create!(
    title: movie['title'],
    year: movie['year'],
    rating: movie['rating'],
    image: movie['image']
  )
  i = 0
  movie["actors"].each do |actor|
    if Actor.find_by(fullname: actor).nil?
      actor_avatar_url = movie['actor_facets'][i].split("|").first
      Actor.create!(fullname: actor, avatar: actor_avatar_url)
      i += 1
    end
    Cast.create!(movie: new_movie, actor: Actor.find_by(fullname: actor))
  end


  movie["genre"].each do |genre|
    if Genre.find_by(content: genre).nil?
      Genre.create!(content: genre)
    end
    Category.create!(movie: new_movie, genre: Genre.find_by(content: genre))
  end
  index += 1
  p index
end

p '--------------------'
p 'Terminé'
p '--------------------'
