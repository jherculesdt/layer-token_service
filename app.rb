#!/usr/bin/env ruby
require 'bundler'
Bundler.require

require "sinatra/json"
require "sinatra/cross_origin"

class TokenService < Sinatra::Base
  helpers Sinatra::JSON
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
  end

  get '/' do
    cross_origin

    response = {
      errors: false
    }

    json response
  end
  
  post '/hello/layer' do
    cross_origin

    response = {
      token: Layer::IdentityToken.new(params[:user_id], params[:nonce]),
      params: params
    }

    json response
  end
end
 
if __FILE__ == $0
  TokenService.run!
end
