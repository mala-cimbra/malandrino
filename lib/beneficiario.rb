#!/usr/bin/env ruby

# index dei beneficiari
get '/beneficiari'do
    # tirami fuori la lista
    @lista_beneficiari = $db.execute("SELECT * FROM beneficiari;")
    if @lista_beneficiari.empty? # se è vuota
        # mostra pagina lista vuota
        erb :"beneficiari/beneficiari_vuoto"
    else
        # sennò lista tutto
        erb :"beneficiari/beneficiari"
    end
end

get '/beneficiari/new' do
    # pagina nuovo beneficiario
    erb :"beneficiari/beneficiari_new"
end

post '/beneficiari/new' do
    # TODO: cercami il beneficiario, se esiste torna indrio
    nome_beneficiario = params["nome_beneficiario"]
    #--- dati in JSON, valori in aggiunta OPZIONALI
    numero_telefono = params["tel"] # numero di telefono
    email = params["email"]         # email
    indirizzo = params["addr"]      # indirizzo
    note = params["note"]           # note

    # crea l'hash da trasformare in JSON
    dati_beneficiario = {numero_telefono: numero_telefono, email: email, indirizzo: indirizzo, note: note}.to_json

    # metti nel db
    $db.execute("INSERT INTO beneficiari VALUES(NULL, '#{nome_beneficiario}', '#{dati_beneficiario}');")

    # torna alla lista dei beneficiari
    redirect to('/beneficiari')
end

get '/beneficiari/show/:id' do |id|
    # tirami fuori i dati di quel beneficiario
    dati_beneficiario = $db.execute("SELECT * FROM beneficiari WHERE id = #{id};")
    if dati_beneficiario.empty? # se è vuoto torna indrio, è un minimo di sicurezza anti-scazzo
        redirect to('/beneficiari')
    else
        # tira fuori tutti i dati
        @id_beneficiario = dati_beneficiario[0][0]
        @nome_beneficiario = dati_beneficiario[0][1]
        @hash_info = JSON.parse(dati_beneficiario[0][2])

        # e mostrami la paggina
        erb :"beneficiari/beneficiari_show"
    end
end

get '/beneficiari/edit/:id' do |id|
    # modifica, tiralo fuori per id
    dati_beneficiario = $db.execute("SELECT * FROM beneficiari WHERE id = #{id};")

    # sicurezza anti-scazzo
    if dati_beneficiario.empty?
        redirect to('/beneficiari')
    else
        # tira fuori i dati base da vedere
        @id_beneficiario = dati_beneficiario[0][0]
        @nome_beneficiario = dati_beneficiario[0][1]
        @hash_info = JSON.parse(dati_beneficiario[0][2])

        #in posizione da modifica
        erb :"beneficiari/beneficiari_edit"
    end
end

post '/beneficiari/edit/:id' do |id|
    # cercamelo nel caso non scazzi, prende l'id dall'ulr della pagina, ma mi sa che cambierò e userò il params["id"]
    cerca_beneficiario = $db.execute("SELECT * FROM beneficiari WHERE id=#{id};")
    if cerca_beneficiario.empty?
        # se è vuoto vai fuori dai coglioni
        redirect to('/beneficiari')
    else
        # tirami fuori tutti i dati nel post
        id_beneficiario = params["id"]
        nome_beneficiario = params["nome_beneficiario"]
        numero_telefono = params["tel"] #
        email = params["email"]         #
        indirizzo = params["addr"]      #
        note = params["note"]

        # Genera JSON
        dati_beneficiario = {numero_telefono: numero_telefono, email: email, indirizzo: indirizzo, note: note}.to_json

        # salva sul DB modificando quella riga
        $db.execute("UPDATE beneficiari SET nome_beneficiario='#{nome_beneficiario}', dati_beneficiario='#{dati_beneficiario}' WHERE id=#{id_beneficiario};")

        # torna a casa
        redirect to("/beneficiari/show/#{id}")
    end
end

# TODO: eliminazione del beneficiario, decidere se mantenere i schei spesi oppure  no.
