require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/hello' do
    # name = params[:name]
    # return "Hello #{name}"
    return erb(:index)
  end

  get '/names' do
    names = params[:names]

    return names.split(",").join(", ")
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]

    return "Thanks #{name}, you sent this message: \"#{message}\""
  end

  post '/sort-names' do
    names = params[:names]
    sorted_names = names.split(",").sort.join(",")
    return sorted_names

  end

end