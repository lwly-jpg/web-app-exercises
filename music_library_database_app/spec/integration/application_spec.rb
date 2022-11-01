require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context 'GET /albums' do
    it 'returns list of albums' do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Surfer Rosa')
      expect(response.body).to include('Released: 1988')
      expect(response.body).to include('Title: Waterloo')
      expect(response.body).to include('Released: 1974')
      expect(response.body).to include('<a href="/albums/2">More info</a>')
      expect(response.body).to include('<a href="/albums/3">More info</a>')
    end
  end

  context 'POST /albums' do

    it 'creates a new album' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: 2)
      expect(response.status).to eq(200)
      get_response = get('/albums')
      expect(get_response.body).to include('Title: Voyage')
      expect(get_response.body).to include('Released: 2022')
    end
  end

  context 'GET /artists' do
    it 'returns list of artists' do
      response = get('/artists')
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context 'POST /artists' do
    it 'creates a new artist' do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie')
      expect(response.status).to eq(200)
      get_response = get('/artists')
      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild Nothing"
      expect(get_response.body).to eq(expected_response)
    end
  end

  context 'GET /albums/:id' do
    it 'returns album by id 2' do
      response = get('/albums/2')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end

    it 'returns album by id 3' do
      response = get('/albums/3')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Waterloo</h1>')
      expect(response.body).to include('Release year: 1974')
      expect(response.body).to include('Artist: ABBA')
    end
  end
end


