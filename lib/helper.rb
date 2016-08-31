#!/usr/bin/env ruby
#------------------
# helpeer
#------------------

def debug(cosa, contenuto)
    puts cosa
    pp contenuto
end

# escape dell'html, ma è da sistemare
def safe_html(testo)
    Rack::Utils.escape_html(text)
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
    # cerca id del beneficiario tramite nome_beneficiario
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

        # ritorniamo l'id del tipo transizione
        id = $db.execute("SELECT id FROM tipo_transizione WHERE nome_tipo_transizione='#{tmp_tipo_transizione}';")
        id.to_i # ritorna l'id
    else
        # [0] perché i dati te li sputa in array annidati
        cerca_id_tipo_transizione[0].to_i
    end
end
=begin
# TODO: da sistemare, ma manca poco
def sistema_categoria(tmp_categoria)
    # la categoria contiene anche le sottocategorie
    # id -> id della categoria
    # id_cat_padre -> id categoria padre (se 0 non ha cat padre)
    # nome_categoria -> nome

    # nome categoria finale visto che sono delimitate dal simbolo (questo qua) >
    # cate_1 id 5 id_padre 0
    # cate_2 id 9 id_padre 5
    # cate_3 id 15 id_padre 9
    # cate_1>cate_2>cate_3
    # splitto ed esce [cate_1, cate_2, cate_3]
    # prendo il last e cerco se esiste
    # se esiste pochi cazzi, id_categoria nella transizione va nel db delle transizioni
    #-----------------
    # se la cat non esiste vado a prendere quello prima
    # nuova_cat[] << tmp_categoria_array.pop
    # e ricerco di nuovo
    # ricerca tmp_categoria_array.last
    # esiste?
    # se sì ho trovato l'id della cat padre (id = 35)
    # e ricostruisco l'albero
    # db.execute(insert cat_padre id = 35, nome cat nuova_cat.last)
    # nuova_cat.count - 1 = 0?  <--------------------------------------------
    # se sì ho finito, fregancazzo                                          |
    # se no, cerco l'id dell'array.pop (cerco e tolgo dall'array)           |
    # creo un nuovo record con array.last                                   |
    # e controllo se c'è una nuova_cat con la dimensione del nuova_cat-------

    tmp_categoria_array = tmp_categoria.split(">") # splitta, questo è un array

    # cerca l'id
    cerca_id_categoria = $db.execute("SELECT id FROM categorie WHERE nome_categoria='#{tmp_categoria_array.last}';")

=begin
    if !cerca_id_categoria.empty? # e qui comincia l'inferno
        cerca_id_categoria
    else
        nuova_cat[] << tmp_categoria.pop # caviamo l'ultimo indice dell'array e lo salviamo
    end
=end
=begin
    nuova_cat = Array.new
    padre_cat = Array.new

    while cerca_id_categoria.empty? && tmp_categoria_array.size > 0 # finché non trova un cazzo cicla
        nuova_cat << tmp_categoria.pop # inserisci l'ultima categoria non trovata in questo array e toglilo dalla ricerca
        if tmp_categoria_array.size > 0
            cerca_id_categoria = $db.execute("SELECT id FROM categorie WHERE nome_categoria='#{tmp_categoria_array.last}';") # cerca
        else
            $db.execute("INSERT INTO categorie VALUES(NULL, 0, '#{nuova_cat.last}');")
        end
    end

=begin
    # una volta fatto ciò abbiamo trovato o creiamo la categoria padre
    if tmp_categoria_array.size = 0

    end
=end
=begin
    padre_cat << nuova_cat.pop
    padre_cat_id = $db.execute("SELECT id FROM categorie WHERE nome_categoria='#{padre_cat.last}';").to_i

    while nuova_cat.size > 1 # adesso si creano dinamicamente le categorie
        $db.execute("INSERT INTO categorie VALUES(NULL, #{padre_cat_id}, '#{nuova_cat.last}');")
        padre_cat << nuova_cat.pop
        padre_cat_id = $db.execute("SELECT id FROM categorie WHERE nome_categoria='#{padre_cat.last}';").to_i
    end

end
=end
