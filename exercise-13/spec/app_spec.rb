require 'rspec'

describe App do
  include Rack::Test::Methods

  def app
    described_class
  end

  it 'expect unauthorised users to receive a 401 (unauthorized)' do
    get '/'
    expect(last_response.status).to eq(401)
  end

  it 'expect an invalid login attempt to receive a 401 (unauthorized)' do
    authorize 'killdozer', 'handbag'
    get '/'
    expect(last_response.status).to eq(401)
  end

  it 'expect an authorised user to receive a 200 (ok)' do
    authorize 'admin', 'admin'
    get '/'
    expect(last_response.status).to eq(200)
  end

end