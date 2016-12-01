#!/usr/bin/env ruby
require 'bundler'
Bundler.require

require "sinatra/json"
require "sinatra/cross_origin"

class TokenService < Sinatra::Base
  helpers Sinatra::JSON
  register Sinatra::CrossOrigin

  enable cross_origin

  get '/' do

    response = {
      errors: false
    }

    json response
  end
  
  post '/hello/layer' do
    response = {
      token: Layer::IdentityToken.new(params[:user_id], params[:nonce])
    }

    json response
  end
end
 
if __FILE__ == $0
  TokenService.run!
end
