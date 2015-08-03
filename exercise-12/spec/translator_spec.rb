require 'rspec'

def stub_translate_service(access_token_response, translate_response)
  stub_request(:post, /.*datamarket.accesscontrol.windows.net.*/).
      to_return(:status => 200, :body => access_token_response)

  stub_request(:get, /.*api.microsofttranslator.com.*/).
      to_return(:status => 200, :body => translate_response)
end

describe Translator do

  access_token_response = "{\"expires_in\":\"599\"}"

  it 'should translate a given string using default language, english' do
    stub_translate_service(access_token_response, '>Chaussettes<')
    expect(subject.translate( 'Socks', to: 'fr' ) ).to eq( 'Chaussettes' )
  end

  it 'should translate a given string using given from language, italian' do
    stub_translate_service(access_token_response, '>Credimi, meglio<')
    expect(subject.translate( 'Crois-moi, en mieux', from: 'fr', to: 'it' ) ).to eq( 'Credimi, meglio' )
  end

  it 'should translate web content using default language' do
    stub_translate_service(access_token_response, '><h1>Glauben an besser</h1><')
    expect(subject.translate( '<h1>Believe in better</h1>', to: 'de' ) ).to eq( '<h1>Glauben an besser</h1>' )
  end

  it 'should translate web content using given from language, french' do
    stub_translate_service(access_token_response, '><h1>Cycling</h1><')
    expect(subject.translate( '<h1>Radfahren</h1>', from: 'de', to: 'en' ) ).to eq( '<h1>Cycling</h1>' )
  end

  it 'expect invalid language extension to return english' do
    stub_request(:post, /.*datamarket.accesscontrol.windows.net.*/).
        to_return(:status => 200, :body => access_token_response)
    stub_request(:get, /.*api.microsofttranslator.com.*/).
        to_return(:status => 500, :body => '')
    expect(subject.translate( 'Socks', to: 'xx' ) ).to eq( 'Socks' )
  end

  it 'expect the cache to be used for the same request' do
    stub_translate_service(access_token_response, '>Chaussettes<')
    expect(subject.translate( 'Socks', to: 'fr' ) ).to eq( 'Chaussettes' )
    WebMock.reset!
    expect(subject.translate( 'Socks', to: 'fr' ) ).to eq( 'Chaussettes' )
  end
end