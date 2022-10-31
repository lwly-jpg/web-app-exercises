require_relative '../../app'
require 'rack/test'
require 'spec_helper'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /hello' do
    it 'contains a H1 title' do
      response = get('/hello')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Hello!</h1>')
    end

    xit 'returns "Hello Ari"' do
      response = get('/hello?name=Ari')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Ari")
    end

    xit 'returns "Hello Ana"' do
      response = get('/hello?name=Ana')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Ana")
    end
  end
 
  context 'GET /names' do
    it 'returns list of names' do
      response = get('/names?names=Julia,Mary,Karim')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST /" do
    it 'returns list of names sorted in alphabetical order' do
      response = post('/sort-names', names: 'Joe,Alice,Zoe,Julia,Kieran')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice,Joe,Julia,Kieran,Zoe')
    end

  end
end