#!/usr/bin/env ruby
#-----
=begin
Pagina per la gestione dei conti

I conti sono gestiti da una tabella conti
0 - id (che poi verrà usato per richiamare questa riga)
1 - nome_conto
2 - tipo_conto
3 - valuta
4 - l_inizio (liquidità iniziale)
5 - l_attuale (liquidità attuale) quando sarà creato l_inizio = l_attuale per forza di cose
6 - data_creazione (data apertura o data creazione quando è stato fatto salva?) classe Time
7 - dati_conto (JSON e ci metterò qualcosa)

=end

get '/conti' do
    # tiro fuori la lista dei conti
    # il dato è posto come
    # [[conto1], [conto2], ...]
    @lista_conti = $db.execute("SELECT * FROM conti;")
    
    # se i conti sono più di zero...
    # magari bisogna renderlo più elegante
    # solo che mi scazza avere HTML nel codice, preferirei avere tutto su erb
    if @lista_conti.count > 0
        @message = "Hai più di un conto."
    else
        @message = "Non hai nessun conto. Creane uno!"
    end
    
    # mappa l'icona
    # per ogni array cambia l'indice 2 con l'html dell'icona
    @lista_conti.map do |riga_conto|
        case riga_conto[2]
        when "banca"
            riga_conto[2] = "<i class=\"fa fa-university\" aria-hidden=\"true\"></i>"
        when "portafogli"
            riga_conto[2] = "<i class=\"fa fa-money\" aria-hidden=\"true\"></i>"
        when"cartacredito"
            riga_conto[2] = "<i class=\"fa fa-credit-card\" aria-hidden=\"true\"></i>"
        when "paypal"
            riga_conto[2] = "<i class=\"fa fa-paypal\" aria-hidden=\"true\"></i>"
        else
            riga_conto[2] = "<i class=\"fa fa-question-circle\" aria-hidden=\"true\"></i>"
        end
    end

    erb :conti
end

get '/conti/new' do
    erb :conti_new
end

post '/conti/new' do
    nome_conto = params["nome_conto"]
    tipo_conto = params["tipo_conto"]
    valuta = params["valuta"]
    l_inizio = params["l_inizio"].to_f
    $db.execute("INSERT INTO conti VALUES(NULL, '#{nome_conto}', '#{tipo_conto}', '#{valuta}', #{l_inizio}, #{l_inizio}, '#{Time.now}', '{}');")

    redirect to('/conti')
end

get '/conti/:id' do |id|
end

get '/conti/edit/:id' do |id|
end
