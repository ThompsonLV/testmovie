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

p 'Extraction des données'
p '--------------------'
url = "https://gist.githubusercontent.com/alexandremeunier/49533eebe2ec93b14d32b2333272f9f8/raw/924d89e2236ca6fa2ade7481c91bfbf858c49531/movies.json"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

index = 0

p 'Création des films'
p '--------------------'
movies.take(20).each do |movie|

  poster_url = movie['image']
  uri = URI.parse(poster_url)
  response = Net::HTTP.get_response(uri)

  if response.is_a?(Net::HTTPSuccess)
    new_movie = Movie.create!(
      title: movie['title'],
      year: movie['year'],
      rating: movie['rating'],
      image: movie['image']
    )
  else
    new_movie = Movie.create!(
      title: movie['title'],
      year: movie['year'],
      rating: movie['rating'],
      image: "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg"
    )
  end

  i = 0

  p 'Création des acteurs'
  p '--------------------'
  movie["actors"].each do |actor|
    if Actor.find_by(fullname: actor).nil?

      actor_avatar_url = movie['actor_facets'][i].split("|").first
      uri = URI.parse(actor_avatar_url)
      response = Net::HTTP.get_response(uri)

      if response.is_a?(Net::HTTPSuccess)
        Actor.create!(fullname: actor, avatar: actor_avatar_url)
      else
        Actor.create!(fullname: actor, avatar: "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg")
      end
      i += 1
    end
    Cast.create!(movie: new_movie, actor: Actor.find_by(fullname: actor))
  end


  p 'Création des genres'
  p '--------------------'
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
