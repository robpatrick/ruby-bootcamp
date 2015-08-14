require 'tilt/nokogiri'
require_relative '../../exercise-12/lib/translator'

class Linguine

  def initialize( translator )
    @translator = translator
  end

  def call(env)
    to_language = determine_language( env['PATH_INFO'] )
    page = "<html><head><title>#{title}</title></head><body>#{body}</body></html>"
    ['200', {'Content-Type' => 'text/html'}, [translate_page( page, to_language )]]
  end

  private

  def determine_language( path )
    language = 'en'
    language = path[path.index( '.' ) + 1 , path.length] if path.index( '.' )
    raise ArgumentError, 'Path is invalid' unless language.length == 2
    language
  end

  def translate_page( body, to_language )
    doc = Nokogiri::HTML.parse(body) { |cfg| cfg.noblanks }
    doc.traverse do |node|
      if node.text?
        node.content = @translator.translate( node.content, to: to_language )
      end
    end
    doc.to_s
  end
end