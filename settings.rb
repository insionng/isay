#encoding:utf-8
require "time"
require "./helpers/pwhash"

module ISay
	class App < Sinatra::Base
		configure :development do
			register Sinatra::Reloader
		end
		set :port,80
		set :server,'thin'#'webrick'
		
		enable :sessions

	end
end