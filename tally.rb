require 'json'

@root = 'imrad.ward.asia.wiki.org'

@todo = ["welcome-visitors"]
@done = []

def visit slug
  page = JSON.parse `curl -s #{@root}/#{slug}.json`
  puts page['story'][0]['text']
end

visit @todo.pop