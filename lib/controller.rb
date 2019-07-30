# frozen_string_literal: true

require 'bundler'
Bundler.require

require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
  # Home
  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  # New gossip
  get '/gossips/new/' do
    erb :new_gossip
  end

  # New gossip - post
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  # Gossip x
  get '/gossips/:id' do
    erb :show, locals: { gossip: Gossip.find(params['id'].to_i), comments: Comment.all_for_gossip(params['id']) }
  end

  # Edit gossip x
  get '/gossips/:id/edit' do
    erb :edit, locals: { gossip: Gossip.find(params['id'].to_i) }
  end

  # Edit gossip x - post
  post '/gossips/:id/update' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).update(params["id"].to_i)
    redirect '/'
  end

  # New comment - post
  post '/gossips/:id/comment' do
    Comment.new(params['id'], params["gossip_author"], params["gossip_content"]).save
    redirect '/gossips/' + params['id']
  end

  # Delete the gossip
  get '/gossips/:id/delete' do
    Gossip.delete_at(params['id'].to_i)
    redirect '/'
  end
end
