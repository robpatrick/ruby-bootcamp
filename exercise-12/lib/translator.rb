require 'faraday'
require 'json'
require 'cgi'

class Translator

  ACCESS_TOKEN_URL = 'http://api.microsofttranslator.com/v2/Http.svc/Translate'
  TRANSLATION_URL = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
  CLIENT_ID = 'rb-linguine-1'
  SHH_CLIENT_SECRET = 'gcqTSmixEmpatE1C+zpFpEZ2bnCtAHCn/5t1FR8USDk='
  SCOPE = 'http://api.microsofttranslator.com'
  GRANT_TYPE = 'client_credentials'

  def translate( phrase, from: 'en', to: )
    @access_token = fetch_access_token
    conn = Faraday.new ACCESS_TOKEN_URL
    translate_response = conn.get do |req|
      req.params = {:text => phrase,
                    :from => from,
                    :to => to}
      req.headers['Authorization'] = "Bearer #{@access_token['access_token']}"
    end
    determine_result( translate_response, phrase )
  end


  def determine_result( translate_response, phrase )
    phrase = CGI.unescapeHTML(translate_response.body.match(/>(.*)</)[1]) if translate_response.status == 200
    phrase
  end

  private

  def fetch_access_token
    return @access_token if @access_token and Time.now < @access_token['expires_at']
    response = Faraday.post TRANSLATION_URL,
                            {:client_id => CLIENT_ID,
                             :client_secret => SHH_CLIENT_SECRET,
                             :scope => SCOPE,
                             :grant_type => GRANT_TYPE}

    access_token = JSON.parse response.body
    access_token['expires_at'] = Time.now + access_token['expires_in'].to_i
    access_token
  end
end