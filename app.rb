#!/usr/bin/env ruby
require 'bundler'
Bundler.require

require "sinatra/json"
require "sinatra/cross_origin"

set :protection, false

class TokenService < Sinatra::Base
  helpers Sinatra::JSON
  register Sinatra::CrossOrigin

  configure do
    set :allow_origin, :any
  end

  get '/' do
    cross_origin

      response = {
        errors: false
      }

      json response
    end
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
