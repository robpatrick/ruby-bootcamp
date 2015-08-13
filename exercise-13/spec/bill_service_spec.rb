require 'rspec'

describe BillService do
  include Rack::Test::Methods

  def app
    BillService.new
  end

  it 'expect response body to include the bill json' do
    get '/bill'
    last_response
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('statement')
    expect(last_response.body).to include('generated')
    expect(last_response.body).to include('package')
    expect(last_response.body).to include('calls')
  end
end




