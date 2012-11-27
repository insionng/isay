#encoding:utf-8
require "time"
require "./helpers/pwhash"

module ISay
	class App < Sinatra::Base
		dataset = Sequel::Model.db.from(:topics)
		usr = Sequel::Model.db.from(:users)

		get '/favicon.ico' do
			send_file "favicon.ico"
		end


		get '/' do
		  	erb:index,:locals=>{
		  		:dataset_all=>dataset.order(:id).reverse.limit(10),
		  	}
		end

		not_found do
			'没有，真的没有~'
		end
	end
end