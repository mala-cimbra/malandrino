#!/usr/bin env ruby
#--------
=begin
pagina delle categorie
DATABASE
ID - id_cat_padre - nome_categoria
=end

get '/categorie' do
    # cerca se ci sono categorie
    @lista_categorie = $db.execute("SELECT * FROM categorie;")

    # se è vuoto c'è la vuotopagina
    if @lista_categorie.empty?
        erb :"categorie/categorie_vuoto"
    else

        # sennò mostrami la lista
        erb :"categorie/categorie"
    end
end

get '/categorie/new' do

    # pagina nuova categoria
    erb :"categorie/categorie_new"
end

post '/categorie/new' do
    # da lavorarci pesantemente con creazione dinamica categorie
    lista_categorie = $db.execute("SELECT * FROM categorie;");
    nome_categoria = params["nome_categoria"]
    # splitta se contiene sottocategorie
    array_categoria = nome_categoria.split(">")

    # inserisci nel db e redireziona
    $db.execute("INSERT INTO categorie VALUES(NULL, #{id_cat_padre}, '#{nome_categoria}');")
    redirect to('/categorie')
end


get '/categorie/show/:id' do |id|
    # mostra categoria, ma non è molto utile al momento, magari listo le operazioni con questa categoria
end

get '/categorie/edit/:id' do |id|
    # modifica principalmente del nome
end

post '/categorie/edit/:id' do |id|
    # il post
end

# TODO: eliminazione della categoria, devo inventarmi qualcosa.
