require 'faraday'

def mock_translator( subj )
  translator = double
  allow(translator).to receive(:translate).and_return('Hallo!')
  subj.instance_variable_set(:@translator, translator)
end

describe Linguine do

  page_body = '<html><head><title>Hello page!!</title></head><body>Hello</body></html>'
  describe '#call' do

    it 'expect the page to be translated to german' do
      class MockPage < Linguine
        def title
          'title'
        end
        def body
          '<h1>Hello!</h1>'
        end
      end
      mock_page = MockPage.new
      mock_translator(mock_page)
      result = mock_page.call( {'PATH_INFO' => '/home.de'})
      expect(result[2][0]).to include('Hallo!')
    end
  end

  describe '#determine_language' do
    it 'expect English as the default to language when no path supplied' do
      expect(subject.send :determine_language, '' ).to eq('en')
    end
    it 'expect English as the default to language when no language is supplied' do
      expect(subject.send :determine_language, '/home' ).to eq('en')
    end
    it 'expect English as the default language when no language extension is supplied in nested path' do
      expect(subject.send :determine_language, '/here/where/everywhere/home' ).to eq('en')
    end
    it 'expect French from a path with an fr extension' do
      expect(subject.send :determine_language, '/home.fr').to eq('fr')
    end
    it 'expect Italian from a nested path and an it extension' do
      expect(subject.send :determine_language, '/here/there/everywhere/home.it').to eq('it')
    end
    it 'expect an invalid path should throw an argument error' do
      expect{ subject.send :determine_language, '/here/there/everywhere/home.' }.to raise_error( ArgumentError )
    end
    it 'expect an invalid path should with multiple extensions to throw an argument error' do
      expect{ subject.send :determine_language, '/here/there/everywhere.de/home.fr' }.to raise_error( ArgumentError )
    end
    it 'expect an invalid path to throw an argument error' do
      expect{ subject.send :determine_language, '/here/there/everywhere/home.france' }.to raise_error( ArgumentError )
    end
  end

  describe '#translate_page' do
    it 'expect the page body to be translated into german' do
      mock_translator(subject)
      expect(subject.send :translate_page, page_body, 'de' ).to include('Hallo!')
    end
  end
end

