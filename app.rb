#!/usr/bin/env ruby
require 'bundler'
Bundler.require

require "sinatra/json"

before do    
   headers 'Access-Control-Allow-Origin' => '*', 
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']  
end

set :protection, false

class TokenService < Sinatra::Base
  helpers Sinatra::JSON

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
