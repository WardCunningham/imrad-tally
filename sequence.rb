require 'json'

@root = 'imrad.ward.asia.wiki.org'
@page = JSON.parse `curl -s #{@root}/imrad-structure-on-wiki.json`
@start = 1543178737

def columns
  columns = []
  @page['journal'].each do |action|
    columns.push action['id'] unless columns.include? action['id']
  end
  columns
end

def chart
  col = columns
  @page['journal'].each do |action|
    t = ((action['date']/1000-@start)/60).floor
    c = col.index action['id']
    puts "#{t.to_s.rjust(4)} #{' '*(2*c)} #{action['type'][0]}"
  end
end

chart
