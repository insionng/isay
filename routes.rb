#encoding:utf-8
require "time"
require "./helpers/pwhash"

class App < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end
	set :port,80
	set :server,'thin'#'webrick'
	
	enable :sessions
	include Pwhash
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

	get '/post' do
		erb :post, :locals=>{
	  		:dataset_all=>dataset.select(:id, :title).order(:title).filter{id < 100}.all,
	  	}
	end

	post '/post' do
		posttitle=params[:posttitle]
		postcontent=params[:postcontent]

		views=1
		dataset.insert(:title => posttitle, :topic => postcontent,:by_username=>'Insion',:by_email=>'insion@lihuashu.com',:views=>views,:created_at=>Time.now,:updated_at=>Time.now)

		redirect '/'
	end

	get '/topic/:id' do
		sid=params[:id]

		erb :topic, :locals=>{
	  		:topic=>dataset.where(:id=>sid).first
	  	}
	end

	not_found do
		'没有，真的没有~'
	end
end
App.run!