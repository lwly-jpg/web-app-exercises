require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /' do
    it 'should get the form' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/hello" method="POST">')
      expect(response.body).to include('<input type="text" name="name" />')
    end
  end

  context 'POST /hello' do
    it 'should get greeting message' do
      response = post('/hello', name: 'Aurora')

      expect(response.status).to eq(200)
      expect(response.body).to include('Hi Aurora!')
    end

    it 'responds with 400 status with URL in parameters' do
      response = post('/hello', name: 'https://www.youtube.com/watch?v=34Ig3X59_qA')
      expect(response.status).to eq(400)
    end

    it 'responds with 400 status with script in parameters' do
      response = post('/hello', name: '<script></script>')
      expect(response.status).to eq(400)
    end
  end
end