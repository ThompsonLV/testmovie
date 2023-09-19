require "json"
require "open-uri"
require "nokogiri"
require "cgi"

p '--------------------'
p 'Destruction des données'
p '--------------------'

# Je supprime toutes mes données pour repartir de zéro
Movie.destroy_all
Genre.destroy_all
Actor.destroy_all
Cast.destroy_all
Category.destroy_all


p 'Extraction des données'
p '--------------------'

# Je récupère mon JSON que je parse
url = "https://gist.githubusercontent.com/alexandremeunier/49533eebe2ec93b14d32b2333272f9f8/raw/924d89e2236ca6fa2ade7481c91bfbf858c49531/movies.json"
movies_serialized = URI.open(url).read
# Je récupère une liste utilisable de movies
movies = JSON.parse(movies_serialized)


p 'Création des données'
p '--------------------'
index = 1

# Pour chaque movie de mon JSON, je vais créer le film, les genres associé et les acteurs associés
movies.each do |movie|
  p "Film #{index}"

  # Je prend l'url du site donné par l'exercice pour récupérer l'url de l'image
  poster_url = movie['image']
  uri = URI.parse(poster_url)
  response = Net::HTTP.get_response(uri)

  # Je vérifie que la réponse ne soit pas une erreur 404
  if response.is_a?(Net::HTTPSuccess)
    image = movie['image']
  else
    # Si c'est le cas, je fais du scrapping sur TMDB (je sais, il y a une API mais c'était pour m'entrainer et allo ciné c'est nul)
    # CGI.escape permet de retirer les caratères illisibles pour la requête (attention il y a un require pour ça)
    query = CGI.escape(movie['title'])
    url = "https://www.themoviedb.org/search?language=en&query=#{query}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)
    # Je retire la partie inutile de ce que je récupère
    url_text = html_doc.search("img.poster").first.values[2].gsub('/t/p/', "").split('/').last
    image = "https://image.tmdb.org/t/p/w188_and_h282_bestv2/#{url_text}"
  end

  # Je crée mon movie avec l'url de l'image exploitable
  new_movie = Movie.create!(
    title: movie['title'],
    year: movie['year'],
    rating: movie['rating'],
    image: image
  )

  # Création acteurs
  i = 0
  movie["actors"].each do |actor|
    # Si l'acteur n'a pas déjà été créé, alors je le crée
    if Actor.find_by(fullname: actor).nil?

      actor_avatar_url = movie['actor_facets'][i].split("|").first
      uri = URI.parse(actor_avatar_url)
      response = Net::HTTP.get_response(uri)

      # Je tente l'url des avatars,
      if response.is_a?(Net::HTTPSuccess)
        Actor.create!(fullname: actor, avatar: actor_avatar_url)
      else
        # Si l'url du dessus me donne une erreur 404, alors je mets une autre image
        Actor.create!(fullname: actor, avatar: "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg")
      end
      i += 1
    end
    # Je crée les données de la table de jointure entre movie et acteur
    Cast.create!(movie: new_movie, actor: Actor.find_by(fullname: actor))
  end


  # Création genres
  movie["genre"].each do |genre|
    # Si le genre n'a pas déjà été créé, alors je le crée
    if Genre.find_by(content: genre).nil?
      Genre.create!(content: genre)
    end
    # Je crée les données de la table de jointure entre movie et genre
    Category.create!(movie: new_movie, genre: Genre.find_by(content: genre))
  end
  index += 1
end

p '--------------------'
p 'Terminé'
p '--------------------'
