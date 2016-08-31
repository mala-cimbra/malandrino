#!/usr/bin/env ruby
#-----
=begin
pagina per la gestione delle operazioni
0 - id INTEGER PRIMARY KEY
1 - id_conto INTEGER
2 - data_operazione NUMERIC
3 - soldi REAL
4 - id_beneficiario INTEGER
5 - id_tipo_transizione INTEGER
6 - descrizione TEXT
7 - id_categoria INTEGER
=end

get '/operazioni' do
    # tirami fuori la lista delle operazioni
    @lista_operazioni = $db.execute("SELECT * FROM operazioni;")

    # se la lista operazioni è vuota
    if @lista_operazioni.empty?
        erb :"operazioni/operazioni_vuoto" # mostra file che dice di aggiungere
    else
        erb :"operazioni/operazioni" # lista le operazioni
    end
    # ora la rogna è mappare gli indici id_* alla tabella
    # quindi sotto di .map
    # id_conto -> questo è un combobox
    # id_beneficiario -> questo ci vuole l'autocomplete e nel caso la creazione dinamica
    # id_tipo_transizione -> idem
    # id_categoria -> idem
end

get '/operazioni/new' do
    # per prima cosa listare i conti presenti
    @conti = $db.execute("SELECT id, nome_conto, tipo_conto, valuta FROM conti;")

    # listare i beneficiari
    @beneficiari = $db.execute("SELECT nome_beneficiario FROM beneficiari;")

    # listare le categorie
    @categorie = $db.execute("SELECT nome_categoria FROM categorie;")

    # listare i tipi di transizione bancomat, diretta, etc..
    @tipo_transizione = $db.execute("SELECT nome_tipo_transizione FROM tipo_transizione;")

    # per ogni conto tira fuori l'iconcina
    @conti.map do |conto|
        case conto[2]
        when "banca"
            conto[2] = "&#xf19c;" # html entity della banca
        when "cartacredito"
            conto[2] = "&#xf09d;"
        when "portafogli"
            conto[2] = "&#xf0d6;"
        when "paypal"
            conto[2] = "&#xf1ed;"
        else
            conto[2] = "&#xf059;" # generico
        end
    end

    #data di oggi
    @oggi = Time.now.year.to_s + "-" + Time.now.month.to_s + "-" + Time.now.day.to_s

    # mostra la maschera della nuova operazione
    erb :"operazioni/operazioni_new"
end

post '/operazioni/new' do
    # dati che non sono da filtrare/controllare
    conto = params["conto"]
    soldi = params["importo"].to_f
    descrizione = params["descrizione"]

    # dati da controllare col db ed eventualmente aggiungere o dare un id
    tmp_data_operazione = params["data"]
    tmp_beneficiario = params["beneficiario"]
    tmp_tipo_transizione = params["tipo_transizione"]
    tmp_categoria = params["categoria"]

    #debug("parametri", params)

    # data operazione da sistemare
    data_operazione = sistema_data(tmp_data_operazione)

    # beneficiario
    beneficiario = sistema_beneficiario(tmp_beneficiario)

    # tipo_transizione
    tipo_transizione = sistema_transizione(tmp_tipo_transizione)

    # categoria TODO: da rivedere che ormai ce l'ho quasi fatta
    categoria = sistema_categoria(tmp_categoria)

    # inserisci nel db



    # torna alla lista delle operazioni
    redirect to ('/operazioni')
end

# boh, vederla in dettaglio
get '/operazioni/:id' do |id|

end

# modificarla giustamente
get '/operazioni/edit/:id' do |id|
end

# eliminarla giustamente
get '/operazioni/delete/:id' do |id|
end
