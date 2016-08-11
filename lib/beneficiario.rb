#!/usr/bin/env ruby

get '/beneficiari'do
    lista_beneficiari = $db.execute("SELECT nome_beneficiario FROM beneficiari;")
    if lista_beneficiari.empty?
        erb :beneficiari_vuoto
    else
        erb :beneficiari
    end
end

get '/beneficiari/new' do
    erb :beneficiari_new
end

post '/beneficiari/new' do
    nome_beneficiario = params["nome_beneficiario"]
    #--- dati in JSON
    numero_telefono = params["tel"] #
    email = params["email"]         #
    indirizzo = params["addr"]      #

    dati_beneficiario = {numero_telefono: numero_telefono, email: email, indirizzo: indirizzo}
    
    # metti nel db
    $db.execute("INSERT INTO beneficiari VALUES(NULL, '#{nome_beneficiario}', '#{dati_beneficiario.to_json}');")
    
    redirect to('/beneficiari')
end

get '/beneficiari/show/:id' do |id|

end

get '/beneficiari/edit/:id' do |id|

end

post '/beneficiari/edit/:id' do |id|

end