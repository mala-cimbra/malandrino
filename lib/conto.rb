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
    @lista_conti = $db.execute("SELECT * FROM conti;")
    if @lista_conti.count > 0
        @message = "Hai più di un conto."
    else
        @message = "Non hai nessun conto. Creane uno!"
    end
    @lista_conti.map do |riga_conto|
        case riga_conto[2]
        when "banca"
            icona = "<i class=\"fa fa-university\" aria-hidden=\"true\"></i>"
        when "portafogli"
            icona = "<i class=\"fa fa-money\" aria-hidden=\"true\"></i>"
        when"cartacredito"
            icona = "<i class=\"fa fa-credit-card\" aria-hidden=\"true\"></i>"
        when "paypal"
            icona = "<i class=\"fa fa-paypal\" aria-hidden=\"true\"></i>"
        else
            icona = "<i class=\"fa fa-question-circle\" aria-hidden=\"true\"></i>"
        end
        riga_conto[2] = icona
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
