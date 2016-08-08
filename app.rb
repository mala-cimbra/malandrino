#!/usr/bin/env ruby

require 'json'
require 'base64'
require 'digest'

require 'pp' # messaggi di debug

# database
$db = SQLite3::Database.open("database.db")
#---------

#----------------
# carica dinamicamente le librerie all'interno della cartella ./lib
# lista i file e poi li richiama col require
# libs è un array, visto che li tira fuori con lib/libreria.rb
# ci aggiungo un ./ (poi magari alla fine non cambia un cazzo)
libs = Dir.glob(File.join("lib", "*.rb")).map {|file| "./#{file}"}
libs.each do |lib|
    require lib
end
#----------------

get '/' do
    erb :index
end

not_found do
    redirect to('/')
end