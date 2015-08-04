module Helpers

  def stub_translate_service(translate_response)
    stub_request(:post, /.*datamarket.accesscontrol.windows.net.*/).
        to_return(:status => 200, :body => "{\"expires_in\":\"599\"}")

    stub_request(:get, /.*api.microsofttranslator.com.*/).
        to_return(:status => 200, :body => translate_response)
  end

  def verify_translation_service_calls
    WebMock.should have_requested(:post, /.*datamarket.accesscontrol.windows.net.*/).once
    WebMock.should have_requested(:get, /.*api.microsofttranslator.com.*/).once
  end

  def mock_translator( subj )
    translator = double
    allow(translator).to receive(:translate).and_return('Hallo!')
    subj.instance_variable_set(:@translator, translator)
  end
end