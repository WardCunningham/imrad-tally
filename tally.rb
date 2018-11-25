require 'json'

@root = 'imrad.ward.asia.wiki.org'
@sitemap = JSON.parse `curl -s #{@root}/system/sitemap.json`

@todo = ["welcome-visitors"]
@done = []

@start = Time.at 1543178737
@counts = Hash.new 0
@counts['minutes'] = ((Time.now - @start) / 60).floor

def asSlug title
  title.gsub(/\s/, '-').gsub(/[^A-Za-z0-9-]/, '').downcase
end

def todo title
  slug = asSlug title
  return if @todo.include? slug or @done.include? slug
  return unless @sitemap.find {|page| page['slug']==slug}
  @todo.push slug
end

def visit slug
  @done.push slug
  page = JSON.parse `curl -s #{@root}/#{slug}.json`
  @counts['pages'] += 1
  page['story'].each do |item|
    @counts['items'] += 1
    @counts["type #{item['type']}"] += 1
    next if item['text'].nil?
    item['text'].scan(/\[\[(.+?)\]\]/) do |title|
      @counts['links'] += 1
      todo title[0]
    end
  end
end

visit @todo.pop until @todo.empty?
puts JSON.pretty_generate @counts.sort.to_h