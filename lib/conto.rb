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
    lista_conti = $db.execute("SELECT * FROM conti;")
    if lista_conti.count > 0
        @message = "Hai più conti."
    else
        @message = "Non hai nessun conto. Creane uno!"
    end
    erb :conti
end

get '/conti/:id' do |id|
end

get '/conti/new' do
end

get '/conti/edit/:id' do |id|
end
