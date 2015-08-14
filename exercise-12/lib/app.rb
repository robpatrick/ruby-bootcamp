require 'rack'
require_relative './home_page'
require_relative './about'
require_relative './translator'

class RackApp

  SUPPORTED_PAGES = { :homepage => 'HomePage', :about => 'About' }

  def call(env)
    path = env['PATH_INFO']
    requested_page = path[1, (path.index('.') - 1)] if path.index('.')
    if SUPPORTED_PAGES.include?(requested_page.downcase.to_sym)
      clazz = Object.const_get(SUPPORTED_PAGES[requested_page.downcase.to_sym])
      page =  clazz.new( Translator.new )
      page.call( env )
    else
      ['404', {'Content-Type' => 'text/html'}, ['Page not found.']]
    end
  end

end