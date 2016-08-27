#!/usr/bin env ruby
#--------
=begin
pagina delle categorie



=end

get '/categorie' do
    @lista_categorie = $db.execute("SELECT * FROM categorie;")
    if @lista_categorie.empty?
        erb :"categorie/categorie_vuoto"
    else

        erb :"categorie/categorie"
    end
end

get '/categorie/new' do
end

post '/categorie/new' do
end


get '/categorie/show/:id' do |id|

end

get '/categorie/edit/:id' do |id|
end

post '/categorie/edit/:id' do |id|
end
