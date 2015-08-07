require 'rack'
require_relative './home_page'

class RackApp

  SUPPORTED_PAGES = { :homepage => 'HomePage' }

  def call(env)
    path = env['PATH_INFO']
    requested_page = path[1, (path.index('.') - 1)] if path.index('.')
    if SUPPORTED_PAGES.include?(requested_page.downcase.to_sym)
      clazz = Object.const_get(SUPPORTED_PAGES[requested_page.downcase.to_sym])
      page =  clazz.new
      return page.call( env )
    else
      ['404', {'Content-Type' => 'text/html'}, ['Page not found.']]
    end
  end

end