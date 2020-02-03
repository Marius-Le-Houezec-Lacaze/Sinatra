require_relative 'gossip'
require_relative 'comment'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  get '/gossips/' do
    redirect '/'
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :id, locals: {gossips: Gossip.find(params['id']), id: params['id'], comments: Comment.by_id(params["id"].to_i)}
  end

  post '/gossips/:id/' do
    Comment.new(params['id'],params["comment_content"], params["comment_author"]).save
    redirect '/gossips/' + params['id']
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'], gossips: Gossip.find(params['id'])}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params["gossip_author"], params["gossip_content"], params["id"])
    redirect '/'
  end
end