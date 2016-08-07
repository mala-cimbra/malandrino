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
    @lista_operazioni = $db.execute("SELECT * FROM operazioni;")
end

get '/operazioni/new' do

end

post '/operazioni/new' do
    redirect to ('/operazioni')
end

get '/operazioni/:id' do |id|

end

get '/operazioni/edit/:id' do |id|
end
