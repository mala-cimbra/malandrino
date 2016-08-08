#!/usr/bin/env ruby
#------------------
# helpeer
#------------------

def debug(cosa, contenuto)
    puts cosa
    pp contenuto
end

# sistemazione dati input

def data_sistema(tmp_data_operazione)
    data_array = tmp_data_operazione.split("-")
    # anno - mese - giorno
    Time.new(data_array[0], data_array[1], data_array[2])
end

=begin
    # categoria
    categoria = sistema_categoria(tmp_categoria)
=end

def sistema_beneficiario(tmp_beneficiario)
    cerca_id_beneficiario = $db.execute("SELECT id FROM beneficiari WHERE nome_beneficiario='#{tmp_beneficiario}';")
    
    # il beneficiario esiste?
    if cerca_id_beneficiario.empty? # dice vero se l'array è vuoto
        # se è vuoto aggiungilo
        $db.execute("INSERT INTO beneficiari VALUES(NULL, '#{tmp_beneficiario}', '{}');")
        
        #ritorniamo l'id del nuovo beneficiario
        id = $db.execute("SELECT id FROM beneficiari WHERE nome_beneficiario='#{tmp_beneficiario}';")
        id.to_i # ritorna l'id
    else
        # ritorna l'id trovato
        cerca_id_beneficiario.to_i
    end
end

def sistema_transizione(tmp_tipo_transizione)
    cerca_id_tipo_transizione = $db.execute("SELECT id FROM tipo_transizione WHERE nome_tipo_transizione='#{tmp_tipo_transizione}';")
    
    if cerca_id_tipo_transizione.empty?
        # se è vuoto aggiungilo
        $db.execute("INSERT INTO tipo_transizione VALUES(NULL, '#{tmp_tipo_transizione}');")
        
        #ritorniamo l'id del nuovo beneficiario
        id = $db.execute("SELECT id FROM tipo_transizione WHERE nome_tipo_transizione='#{tmp_tipo_transizione}';")
        id.to_i # ritorna l'id
    else
        cerca_id_tipo_transizione.to_i
    end
end

def sistema_categoria(tmp_categoria)
    # la categoria contiene anche le sottocategorie
    # id -> id della categoria
    # id_cat_padre -> id categoria padre (se 0 non ha cat padre)
    # nome_categoria -> nome
    
    # nome categoria finale visto che sono delimitate dal simbolo (questo qua) >
    tmp_categoria_array = tmp_categoria.split(">") # splitta e prendi l'ultima, questo è un array
    
    # carca l'id
    cerca_id_categoria = $db.execute("SELECT id FROM categorie WHERE nome_categoria='#{tmp_categoria_array.last}';")
    
    if cerca_id_categoria.empty? # e qui comincia l'inferno
    
    else
    
    end
    
end

















