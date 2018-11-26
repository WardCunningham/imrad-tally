require 'json'

@root = 'imrad.ward.asia.wiki.org'
@page = JSON.parse `curl -s #{@root}/imrad-structure-on-wiki.json`
@start = 1543178737

@page['journal'].each do |action|
  puts "#{action['id']} #{action['type']} #{((action['date']/1000-@start)/60).floor}"
end