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

    if @lista_operazioni.empty?
        erb :"operazioni/operazioni_vuoto"
    else
        erb :"operazioni/operazioni"
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
    # select * from conti;
    @conti = $db.execute("SELECT id, nome_conto, tipo_conto FROM conti;")
    @beneficiari = $db.execute("SELECT nome_beneficiario FROM beneficiari;")
    @categorie = $db.execute("SELECT * FROM categorie;")
    @tipo_transizione = $db.execute("SELECT * from tipo_transizione;")

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
            conto[2] = "&#xf059;"
        end
    end

    debug("conti", @conti)

    erb :"operazioni/operazioni_new"
end

post '/operazioni/new' do
    # dati che non sono da filtrare/controllare
    id_conto = params["conto"].to_i
    soldi = params["importo"].to_f
    descrizione = params["descrizione"]

    # dati da controllare col db ed eventualmente aggiungere o dare un id
    tmp_data_operazione = params["data"]
    tmp_beneficiario = params["beneficiario"]
    tmp_tipo_transizione = params["tipo_transizione"]
    tmp_categoria = params["categoria"]

    debug("parametri", params)

    # data operazione da sistemare
    data_operazione = sistema_data(tmp_data_operazione)
    # beneficiario
    beneficiario = sistema_beneficiario(tmp_beneficiario)
    # tipo_transizione
    tipo_transizione = sistema_transizione(tmp_tipo_transizione)
    # categoria
    categoria = sistema_categoria(tmp_categoria)

    redirect to ('/operazioni')
end

get '/operazioni/:id' do |id|

end

get '/operazioni/edit/:id' do |id|
end

get '/operazioni/delete/:id' do |id|
end
