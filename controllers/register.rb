#encoding:utf-8
require "time"
require "./helpers/pwhash"

module ISay
	class App < Sinatra::Base

		dataset = Sequel::Model.db.from(:topics)
		usr = Sequel::Model.db.from(:users)

		get '/register' do
			erb :register
		end

		post '/register' do
			email=params[:email]
			pw=params[:password]
			repw=params[:resure]
			pws=Pwhash.encrypt(pw)
			unless pw==repw
				redirect '/register'
			
			else
				usr.insert(:email =>email, :password =>pws,:username=>'Insion',:created_at=>Time.now,:updated_at=>Time.now)

				redirect '/'
			end
		end
	end
end