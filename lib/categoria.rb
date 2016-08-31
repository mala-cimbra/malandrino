#!/usr/bin env ruby
#--------
=begin
pagina delle categorie
DATABASE
ID - id_cat_padre - nome_categoria
=end

get '/categorie' do
    # cerca se ci sono categorie
    @lista_categorie = $db.execute("SELECT * FROM categorie ORDER BY id_cat_padre;")

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
    # TODO: non è importante al momento farla
end

get '/categorie/edit/:id' do |id|
    # modifica del nome e basta
    @dati_categoria = $db.execute("SELECT * FROM categorie WHERE id=#{id};")

    erb :"categorie/categorie_edit"
end

post '/categorie/edit/:id' do |id|
    # il post
    nuovo_nome_categoria = params["nome_categoria"]
    controllo_id = params["id"].to_i

    if id.to_i == controllo_id
        $db.execute("UPDATE categorie SET nome_categoria='#{nuovo_nome_categoria}' WHERE id=#{controllo_id};")
        redirect to("/categorie/show/#{id}")
    else
        redirect to('/categorie')
    end
end

# TODO: eliminazione della categoria, devo inventarmi qualcosa.
