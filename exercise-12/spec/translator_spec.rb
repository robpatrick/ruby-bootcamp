require 'rspec'
require 'helpers'

describe Translator do
  include Helpers

  after(:each) do
    verify_translation_service_calls
  end

  it 'should translate a given string using default language, english' do
    stub_translate_service('>Chaussettes<')
    expect(subject.translate( 'Socks', to: 'fr' ) ).to eq( 'Chaussettes' )
  end

  it 'should translate a given string using given from language, italian' do
    stub_translate_service('>Credimi, meglio<')
    expect(subject.translate( 'Crois-moi, en mieux', from: 'fr', to: 'it' ) ).to eq( 'Credimi, meglio' )
  end

  it 'should translate web content using default language' do
    stub_translate_service('><h1>Glauben an besser</h1><')
    expect(subject.translate( '<h1>Believe in better</h1>', to: 'de' ) ).to eq( '<h1>Glauben an besser</h1>' )
  end

  it 'should translate web content using given from language, french' do
    stub_translate_service('><h1>Cycling</h1><')
    expect(subject.translate( '<h1>Radfahren</h1>', from: 'de', to: 'en' ) ).to eq( '<h1>Cycling</h1>' )
  end

  it 'expect invalid language extension to return english' do
    stub_translate_service('><h1>Cycling</h1><')
    stub_request(:get, /.*api.microsofttranslator.com.*/).
        to_return(:status => 500, :body => '')
    expect(subject.translate( 'Socks', to: 'xx' ) ).to eq( 'Socks' )
  end

  it 'expect the cache to be used for the same request' do
    stub_translate_service('>Chaussettes<')
    expect(subject.translate( 'Socks', to: 'fr' ) ).to eq( 'Chaussettes' )
    expect(subject.translate( 'Socks', to: 'fr' ) ).to eq( 'Chaussettes' )
  end
end