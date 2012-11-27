#encoding:utf-8
require "time"
require "./helpers/pwhash"

module ISay
	class App < Sinatra::Base

		dataset = Sequel::Model.db.from(:topics)
		usr = Sequel::Model.db.from(:users)

		get '/login' do
			erb :login
		end

		post '/login' do
			email=params[:email]
			pw=params[:password]
			gusr=usr.first(:email=>email)
			unless gusr==nil
				unless Pwhash.validate(gusr[:password],pw)
					'密码错误！'
				else
					redirect '/'
				end	
			else
				'Email不存在！'
			end
			
		end

	end
end