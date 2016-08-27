#!/usr/bin env ruby
#--------
=begin
pagina delle categorie
DATABASE
ID - id_cat_padre - nome_categoria
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
    erb :"categorie/categorie_new"
end

post '/categorie/new' do
    lista_categorie = $db.execute("SELECT * FROM categorie;");
    nome_categoria = params["nome_categoria"]
    array_categoria = nome_categoria.split(">")


    $db.execute("INSERT INTO categorie VALUES(NULL, #{id_cat_padre}, '#{nome_categoria}');")
end


get '/categorie/show/:id' do |id|

end

get '/categorie/edit/:id' do |id|
end

post '/categorie/edit/:id' do |id|
end
